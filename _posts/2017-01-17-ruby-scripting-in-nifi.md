---
title: "Ruby Scripting in NiFi"
layout: post
date: 2017-01-17 17:47:06 GMT
---

# Ruby Scripting in NiFi
Today I was asked about an issue that I didn't know how to solve using NiFi. On the surface it sounded simple; just map an attribute to another value. The attribute to map was 'port' and based on the port number just add an attribute to more easily identify the system downstream. E.g. for port 10003; syslog:local, for 10004; syslog:db1, etc. After a bit of digging I found a few different options to solve this.

## Many UpdateAttribute Processors
The first is to create a new UpdateAttribute processor for each incoming stream. This labels (places an attribute) on all files that come in from that listener. It looked like this:

![Multiple UpdateAttribute Processors]({{ site.baseurl }}/images/multiple_attribute_updates.png)

This looks a bit confusing and tedious but is very precise and arguably easier to read, especially when we label the processors. It also has the added advantage of not having to change the port in more than one place. If for example, the local logs coming in over port 10002 need to change to port 10003, then we just make that change in the ListenSyslog processor and the rest remains unchanged.

## One UpdateAttribute Using the Advanced
The advanced option allowed me to keep all the configuration in one place, easily mapping port numbers to tags. The two disadvantages I ran into were:

1. A fairly tedious process to get each mapping. It involved:
 * Create new rule
 * Add name
 * Search for existing rule to import
 * Change port number and associated label
2. Must now change the port in two different places if it were to change

I would look like:
![Single UpdateAttribute with Advanced Features]({{ site.baseurl }}/images/single-updateattribute-with-advanced-features.png)

## ExecuteScript Processor
This again allows me to keep all the configuration in one place and makes it much easier to make changes.
I created a processor that stores the mappings in a hash and adds the correct attribute appropriately. It looks like so:

![ExecuteScript Processor for Mapping]({{ site.baseurl }}/images/executescript-processor-for-mapping.png)

From the UI perspective it looks very similar to the single UpdateAttribute solution. This requires the addition of the script:

{% highlight ruby %}
map = {
  10 => "system1",
   9 => "system2",
   8 => "system3",
}
map.default = "unknown"

flowFile = session.get()
return unless flowFile

label = map[flowFile.getAttribute("port")]
flowFile = session.putAttribute(flowFile, "system", label)

session.transfer(flowFile, REL_SUCCESS)
session.commit()
{% endhighlight %}

It is more complex by adding the need to understand a scripting language and also doesn't remove the requirement of changing the port number in more than one place. The script can add more complexity if it becomes necessary to reference as a file rather than using the 'Script Body' option in the processor. The main advantage is that it makes it easier to change the mapping - just copy and paste one of the lines of the hash and make changes all in one place.

Given NiFi's goal of minimising the need for data flow managers to know how to code, it's unlikely this is the best approach.

# Conclusion
The first option is quite foreign to programmers who feel like it isn't generic. This is understandable given that it does feel a bit like copy and paste. I would say it is the most NiFi way of achieving the mapping as it is the solution which is most self-describing and resistant to change.
