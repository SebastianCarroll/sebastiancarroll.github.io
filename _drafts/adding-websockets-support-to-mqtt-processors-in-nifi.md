---
title: "Adding WebSockets Support to MQTT Processors in NiFi"
layout: post
date: 2017-09-13 12:49:28 BST
---

# Adding WebSockets Support to MQTT Processors in NiFi
A while ago on a contract there was a push to get NiFi connected to a secure MQTT broker using WebSockets. Eventually this solution was abandoned for Kafka but rather than lose the work I thought it would be a good thing to contribute back to the core given that [NIFI-2663](https://issues.apache.org/jira/browse/NIFI-2663) is still open. 

Since this initial work was a while ago, the first thing I did was delete my remote git branch, pull master from [git NiFi]https://github.com/apache/nifi), rebase my local branch on to the most up to date master and push that back to the server. I could have just merged new master -> existing nifi-2663 but that is a bit messier.

Since the initial work was more of a PoC, I didn't update the validation or testing code (I know, I know). So I changed the required validation and looked into the tests. Initially I thought I could just copy the tests and change the `ssl` to `wss` and `tcp` to `ws`, however that failed. I got `MqttException (0) - java.io.IOException: WebSocket Response header: empty sec-websocket-protocol` for `wss` and `MqttException (0) - java.io.IOException: WebSocket Response header: Invalid response from Server, It may not support WebSockets.` for `ws`. 

Its a good question though, I probably should check that the version of MQTT test server (moquette in this case) actually does support WebSockets.
The relevant version I am using:

~~~
        <dependency>
            <groupId>io.moquette</groupId>
            <artifactId>moquette-broker</artifactId>
            <version>0.8.1</version>
            <scope>test</scope>
        </dependency>
~~~

That version is almost 18months old now, having been [released](https://github.com/andsel/moquette/releases/tag/v0.8.1) in Feb 2016. Looks as though it did support WebSockets even from v0.8.1. 

Ignored the tests for now to see if I could get it working in the wild. I immediately hit this error:

~~~
Caused by: java.lang.IllegalArgumentException: ws://test.mosquitto.org:8080
~~~

I must be using an old build. Whats going on here.
