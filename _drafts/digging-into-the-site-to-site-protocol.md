---
title: "Digging Into the Site-to-Site Protocol"
layout: post
date: 2017-09-25 14:37:24 BST
---

# Digging Into the Site-to-Site Protocol
I have always liked the simplicityof the S2S protocol that NiFi uses. Some good features include:
* Sending of full flow files including attributes. Means you can keep the metadata accross multiple systems and make decisions downstream
* Balancing across nodes when sending to a cluster
* Simplifies networks: Can go to the same port as the UI and also use http underlying to go through proxies

However I have no idea how it actually works under the hood so really want to dig into it a bit more and see what happens. Specifially I'm looking at error handling: what happens if a batch fails? Does it retry? If its a cluster can it retry to a different node?

