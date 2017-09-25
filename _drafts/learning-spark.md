---
title: "Learning Spark"
layout: default
date: 2017-08-29 19:47:54 BST
---

# Learning Spark
I've recently been doing more work with spark and wanted to go back and review all
the training that I've done and write it up.

# Why would I use Spark
The main benefit of Spark over MR is speed: both in execution time and also in
developer time. Spark is advertised as being 100x faster than MR if performing iterative
calculations and 10x if not. This is mainly due to Sparks ability to cache data in
memory for much faster access. There is also the often-overlooked ability to do
iterative development (using the spark shell)

<!-- Add ecosystem here with Spark core, SQL, Steaming, ML and GraphX? -->

# What is Spark (The basics)

## The Resilient Distributed Dataset
The main component to understand with Spark is the Resilient Distributed Dataset or RDD. It is the core
abstraction and feeds into much of what Spark does. Some properties of the RDD:

* Dataset: Collection of objects
* Distributed: Stored across disks and machines (partitioned)
* Resilient: Will be rebuilt on failure

Created a number of different ways:

* SparkContext
  * sc.parallelize
  * sc.textFile
* From other transformations

Most ways in which data is brought into spark, writes it to an RDD in some way

## Transformations
Transformations take an existing RDD and create a new RDD from it, with 0 or more changes. At a high level,
transformations will iterate through each element in the RDD and then perform some processing to it. Some common transformations include:

* map - applies a function to each element which returns exactly one element back
* filter - applies a function to each (must return a boolean) and only keeps those elements where the function
returns `true`
* flatMap - like map but not necessarily 1 to 1 between the elements in the source and destination RDD.
For example, splitting an RDD of words into an RDD of characters
* distinct - removes duplicate elements
* sample - takes a random sampling of the RDD
* set operations - union, intersection, subtract, etc

## Actions
Transformations however, aren't very useful on their own. This is because Sparks evaluation is lazy. Never actually runs anything until an Action is called. An Action is when you tell Spark what you what to do with the data you have processed. The simplest action is collect, which just brings all the data back to the single machine to have it all in the one place. Use this with caution however as you could run out of memory if the dataset is too large. Other actions include:
* countByValue - counts up all the values
* count - counts the number of elements
* take - like collect but only for the first specified elements
* top - same as take
* reduce - combines all elements in some way and returns that result

## Shuffles
Spark tries to minimise the amount of data it moves around by sending the code to the data. Sometimes this isn't possible, especially when trying to reduce or group data. To facilitate this, Spark will move the data
to where it is required but in the minimal way.

## Stages and Tasks
Firstly, the DAG scheduler will calculate where the shuffles will occur in the DAG. Each of these shuffles will form the edge for a stage. These stages will then be passed to the Task scheduler to break down into tasks which will be launched via the cluster manager. The workers then executes those tasks on the slave nodes

Each task can operate in parallel

## Architecture
Driver vs executors: A driver is the main executing engine on the the cluster. It calculates the DAG and communicates with the executors and cluster manager to distribute the work to the cluster.


Execution Plan - DAG: How stages -> jobs -> tasks
Fault tolerance

Add Image

## Pair RDD's
Usually used when aggregate or transform data based on a key which is a very common requirement.
Can be created easily by mapping to a 2 tuple to generated a pair RDD. The key and values don't have to be primatives and can be anything really including complex types. A pair RDD gives us additional methods such as:

* ReduceByKey: Like normal reduce but first GroupByKey and then reduce over the values associated with each key. e.g. rdd.reduceByKey((x,y) => x+y). Here I think of x,y more as accumulator and new value where they are added together.
* GroupByKey: Returns a unique collection of keys where each key links to the collection of elements associated with that key
* SortByKey: Sort based on the keys only
* keys(), values(): return a collection of the keys or values respectively

and much more

## Partitioning
PairRDD with be partitioned by hashing of the key
Can give a custom partitioner if don't want the default

# On the Cluster
Submitting
Yarn client/master
Standalone
Broadcast vars
Caching/Persisting

# Spark SQL
Uses the catalyst optimiser. Allows you to write the sequence of commands however is most convinient
and the optimiser will perform those steps in the most efficient way it can. This allows you to
mesh SQL commands with standard Spark RDD programming techniques

This is done with a DataFrame which is essentially a RDD of Row objects with puts
structure onto the Collection
