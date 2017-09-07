---
title: "Back to the Java"
layout: default
date: 2017-09-07 18:28:23 BST
---

# Back to the Java
I used to use Java quite a bit in uni but haven't *really* used it in anger since then. 
I've been using pretty much everything under the sun *but* Java; Bash, Ruby and Scala mainly but also C#, JavaScript, PowerShell, Python as required. I've recently been getting more and more into NiFi and want to get more into contributing. The NiFi community has made my day to day much much easier and I think it's high time I started giving back. Hence the renewed interest in Java.

I started off with a few problems on HackerRank and am now 'graduating' to the command line so I can keep track of my work a bit easier (in git of course). Have to say I am surprised at how easy it has been to pick it back up again.
I was last using it years ago and it's very similar. It's slow rate of change was one of its big drawbacks to me but now I'm very grateful for that when picking it back up again. This is in stark contrast to something like Spark which has changed drastically in even the 9 months I have been learning it.

I started practice with a simple 'repeated character substring' problem ([on github](https://github.com/SebastianCarroll/practice/blob/master/longest_substring/longest_repeated_str.java))
 and I made my first rookie mistake without even completing the canonical 'Hello, World!':

~~~
longest_repeated_str.java:4: error: cannot find symbol
    public static void main(Array[] args) {
                            ^
  symbol:   class Array
  location: class Solution
1 error
~~~

I've gotten used to the Scala idiom of `Array[String]` way of declaring something similar. It wasn't just that, I met a number of things that I had to be reacquainted with:

* The `%n` is the newline in a `System.out.printf` function
* The complexities of primitive types vs objects (e.g. `charAt()` returns `char` not `Character`)
* String comparisons `==` vs `.equals`

Despite the initial setbacks, this little adventure feels like a chance meeting with that old friend that I never really liked but is actually pretty fun!
