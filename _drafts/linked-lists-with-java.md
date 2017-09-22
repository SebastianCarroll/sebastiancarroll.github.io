---
title: "Linked Lists With Java"
layout: post
date: 2017-09-14 19:35:34 BST
---

# Linked Lists With Java
Second thing to try while practicing Java was the quintessential 'Reverse A Linked List' task. I had given this a shot years ago but thought I would give it another shot without referencing my [previous work](https://github.com/SebastianCarroll/AlgorithmsForJava/blob/master/src/Misc/linkedList/LList.java)

First step was to get the basic linked list data structure working and be able to add some elements to it. Second to that I wanted some way to see what was in my linked list so added a print statement. More than anything this was just so I could debug the first method.

The first iteration looked like this
~~~ java
class LinkedList {
    int value;
    LinkedList next;

    LinkedList(int v, LinkedList n) {
        value = v;
        next = n;
    }

    public static void main(String[] args) {
        LinkedList l = new LinkedList(9, null);
        LinkedList l2 = l.add(8).add(7).add(6);
        l2.print();
    }

    public LinkedList add(int i) {
        return new LinkedList(i, this);
    }

    public void print() {
      System.out.println(value);
      if(next == null) return;
      next.print();
    }
}
~~~

Then came the hard part actually work out how to reverse the thing. I could sort of see how it looked in my head. Something like a machine that would look over each element and just keep adding new elements to a new list. Something like this:

TODO: Add gif here? Would be good to work out how to do one

## Inplace vs create new
It is more difficult to do inplace I think because you have to carefully manipulate the pointers to the next.
Create new was a bit easier to handle on my brain (possibly given that I had just created the constructur that way)

## Clean abstraction vs Easy Manipulation
TODO: Talk about reversing linked list where all nodes are also LinkedLists vs one where we update the head and then have a recurse method to simplify

## The Base Case
As I had been taught doing recursion many years ago, i started with the base case. Here we have the `next` being `null` which signifies the end of the list. I thought I would need to take the current node and make a new node with the same value but pointing to the previous one. I came up with this:

~~~ java
public LinkedList reverse(LinkedList tobenext) {
  if(next == null) {
    return new LinkedList(value, tobenext);
  }
}
~~~

`tobenext`: Is the previous node that has been passed in
`value`, `next`: The current values of the node as is, which is the last node in the chain.

## The Step Case
Now that the end case has been done, what about every other case? I want to do basically the same thing with creating the new linked list with reversed pointers, but also need to build up the reversed list to eventually be returned by the step case. I added the following to the if-else

~~~ java
} else {
    LinkedList newcur = new LinkedList(value, tobenext);
    return next.reverse(newcur);
}
~~~

Saw the duplicate code there and cleaned to :

~~~ java
public LinkedList reverse(LinkedList tobenext) {
    LinkedList newcur = new LinkedList(value, tobenext);
    if(next == null) {
        return newcur;
    } else {
        return next.reverse(newcur);
    }
}
~~~

## Only ints? Generics are the way
And finally to make it generic

TODO: Copy the errors here and post resolution
