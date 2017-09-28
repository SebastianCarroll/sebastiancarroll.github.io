---
title: "Linked Lists With Java"
layout: post
date: 2017-09-14 19:35:34 BST
---

# Linked Lists With Java
Second thing I wanted to try while practicing Java was the quintessential 'Reverse A Linked List' task. I had given this a shot years ago but thought I would try again without referencing my [previous work](https://github.com/SebastianCarroll/AlgorithmsForJava/blob/master/src/Misc/linkedList/LList.java)

First step was to get the basic linked list data structure working and be able to add some elements to it. Then I added a print statement so I could see what was in the list. More than anything this was just so I could debug the first method.

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

## Inplace vs create new
It is more difficult to do in-place I think because you have to carefully manipulate the pointers to the next.
Creating a new node each time was a bit easier for my brain (possibly given that I had just created the constructor that way)

## Clean abstraction vs Easy Manipulation
TODO: Talk about reversing linked list where all nodes are also LinkedLists vs one where we update the head and then have a recurse method to simplify. In my previous attempt I had created a separate `Node` and `LinkedList` classes. Where the LinkedList class had the reverse method and pointed to the head of the list of nodes. I wasn't particularly happy this this approach as it felt a bit clunky. The definition of a list is that there is a head and a tail where the tail is also a list. This doesn't really hold true when doing it this way. Instead I removed the `Node` class and just did everything from the `LinkedList` class. I thought this would make the manipulations harder but feel closer to the abstraction.



Then came the hard part; actually work out how to reverse the thing. I could sort of see how it looked in my head.
Something like a machine that would look over each element and just keep adding new elements to a new list, but in reverse. Sort of like this:

TODO: Add gif here? Would be good to work out how to do one

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

I identified the duplicate code there and cleaned to it up a bit:

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
I wanted to make it more general so reached for generics. As a first pass I just replaced all the `int` references with `T` but then generated a lot of `unchecked call` and `unchecked conversion` compiler warnings. I clearly don't understand the type system here well enough. After a bit of research I realised there were just areas I had left of the generic marker. For example I converted only the input varible in the `add` method so it looked like:
``` java
    public LinkedList add(T i) {
        return new LinkedList(i, this);
    }
```

but should have been:

``` java
    public LinkedList<T> add(T i) {
        return new LinkedList<T>(i, this);
    }
```

Once I fixed up the missing generic markers, all the warnings were resolved.

## A bit more functional?
When I completed the functional programming course, it was considered good practice to avoid `null` where possible. I have also read a lot about how this is good practice generally so thought I could emulate that here and clean the code a bit more.

Rather than checking for null explicitly I added a method to indicate whether an object was empty and replaced the checks to nulls with calls to `isEmpty()`. For bonus points I cleaned up the `print` method so it first built a string recursively and then printed that out in one go

The finished product (as much as anything every is) is here.

~~~ java
lass LinkedList<T> {

    T value;
    LinkedList<T> next;
    private Boolean empty = false;

    LinkedList(){
        empty = true;
    }

    LinkedList(T v) {
        value = v;
        next = new LinkedList<>();
    }

    LinkedList(T v, LinkedList<T> n) {
        value = v;
        next = n;
    }

    public LinkedList<T> add(T i) {
        return new LinkedList<T>(i, this);
    }

    public Boolean isEmpty() {
        return empty;
    }

    public void print() {
        System.out.println(toString());
    }

    @Override
    public String toString() {
        return next.isEmpty() ? value.toString() : value.toString() + " " + next.toString();
    }

    public LinkedList<T> reverse(LinkedList<T> tobenext) {
        LinkedList<T> newcur = new LinkedList<>(value, tobenext);
        if(next.isEmpty()) {
            return newcur;
        } else {
            return next.reverse(newcur);
        }
    }

    public static void main(String[] args) {
        LinkedList<Integer> l = new LinkedList<>(9).add(8).add(7).add(6);
        l.print(); // Expected: 6 7 8 9
        LinkedList<Integer> lr = l.reverse(new LinkedList<Integer>());
        lr.print(); // Expected: 9 8 7 6
    }
}
~~~

There are still a few issues but overall I'm pretty happy with it
