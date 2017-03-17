---
title: "Keeping Your Dataflows Tidy"
layout: default
date: 2017-03-15 14:55:04 AEDT
---

# Keeping Your Dataflows Tidy
I've seen quite a few data flows over the years and some are easier than others to work with. Here are a few things
I would recommend to help keep your flows maintainable as they grow. Something like the following is 
not uncommon.

![messy_nifi_canvas_example]({{ site.baseurl }}/images/messy_nifi_canvas_example.png)

I don't know 
about you, but even after years of NiFi I can't work out what this is supposed 
to do without digging into the 
internals. Something about Syslog?

## Pick a 'Flow Direction'. 
I generally recommend starting in top left and going to bottom right. This is somewhat arbitrary but makes sense 
to me for two reasons:

 * NiFi is more space efficient stacking processors vertically
 * Flow files then move the same way that information flows in written english (which I am used to)
 
It makes it very easy to see
that anything vertical (down) is the main flow and anything to the right is usually a deviation. Be it error 
handling or a special case. 

Looking at the cleaned up example, you can see more easily that everything to the lower right is error-handling logic.
  
![after picking flow direction]({{ site.baseurl }}/images/after-picking-flow-direction.png)

## Keep Processors Aligned
There's no auto format in NiFi[^1] because it isn't crucial that
things line up pixel perfect, but it is important that they are roughly aligned. Why? It just makes it 
easier to follow. Consider the image below, it's now much easier to see that there are two distinct processor
groups connected with three connections. Its also easy to see that  all those the connections 
are flowing left to right and
represent failures.

Now the right group is the failure path, we can more easily see that the happy path is a ParseSyslog -> 
UpdateAttribute -> ExecuteScript -> PutKafka chain. Much Simpler.

Also, using elbows here is great way to clean up the left ExecuteScript processor failure connection. 
Without this it would be going right though two other processors, decreasing clarity. Arguably it breaks the
top-left,bottom-right rule but is an acceptable trade off I would say. Elbows are easy to create; just double anywhere on the connection and
move the yellow dot around. 

![After Keep Processors Aligned]({{ site.baseurl }}/images/after-keep-processors-aligned.png)

## Use process groups
Process groups can really simplify a flow. Just like functions in maths/programming they serve as an abstraction
layer to encapsulate details. They also help organise the flow. In the shot below, you can see the number of 'things'
in the flow has halved.

Process groups be confusing though and I have some warnings for their use:

* They can be nested and can get confusing after a few levels. This can be mitigated using the bread crumbs 
and maintaining
sensible abstraction layers (see ONE LEVEL OF ABSTRACTION PER FUNCTION in
 [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)).
 
* It is a little bit difficult to move processors over the process group boundary, but you can still
copy-paste over that boundary so it's more of a 'good to know' rather than a deal breaker.

* Once created there is no way to know what a process group does. We get no clues as we do in the standard
flow. You can probably guess that Process Group 3 is still the error handling code from before, but 1 and 2? Who
knows. Properly naming process groups is essential (even with light use)
 
![After Use process groups]({{ site.baseurl }}/images/after-use-process-groups.png)

## Name Everything
Just like functions in code, a good name can mean a world of difference for a processor too. Reading the flow below
is much simpler than it was before. Another area where this really helps is the search. For example.
the flow I'm working on lives with a number of other flows and I tend to use a lot of update attribute 
processors. If I want to find the one in the Handle Failures process group but can only search on its type, 
I get the following

 ![bad search without names]({{ site.baseurl }}/images/bad-search-without-names.png)
 
There are actually eight UpdateAttribute processors returned by that query and would have been a painful search
if I hadn't taken the time to name it correctly. Its usually not difficult to find appropriate names for these. Longer 
and more descriptive is better than short and cryptic (Again I refer to
 [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882) for guidance here)

![After name everything]({{ site.baseurl }}/images/after-name-everything.png)

## Putting it all together
I think you'll agree that the finished product is much simpler than what we started with. It takes some 
discipline to keep a flow maintainable but the benefits are definitely worth the effort.

***
***

[^1]: However, the next release will support horizontal and vertical alignment of selected components.
