---
title: "Azure for HDP deployments"
layout: default
date: 2016-10-24 10:23:00 BST
---

# Azure for HDP Deployments
I recently started working with Azure in the big data space. It was fraught with difficulty and if you are considering the same here are some of the issues that we encountered. 

## Why won't you take my money?
I thought I was going to move quickly now I didn't have to wait weeks to get hardware delivered only to instantly be restricted to 10 cores. The interface gave no clue as to the issue just wouldn't let me create what I needed to despite having the sufficient funds. So much time was wasted trying to work out the problem. To this day I still have no idea how a user would be able to check what limit they were at apart from contacting support. There's also no way to actually increase this limit yourself you must go through support. The SLA? Three days. 
    That was just crippling for us. We were on very tight deadlines and picked Azure exactly for its supposed speed and flexibility, so to be instantly hit with an arbitrary, company imposed roadblock was frustrating to say the least. And by 'frustrating' I mean absolutely unacceptable. This was an enterprise account, not me from my basement.

## Location, Location, Location
I initially deployed into UK South region which seemed reasonable given my location. Unfortunately then I had a really hard time trying to back up the machines. The process itself is fairly arcane and hard to understand, but this was complicated by the UK South region not coming up in the list of places to create a back up vault. Given how difficult it was to work out how to do anything, I thought maybe it was just me but I couldn't work it out so gave up and contacted support. They informed me that due to how recently UK South was set up there is no backup feature yet. 
I was astounded. Not only that, but also UK South was *more expensive* than other options. So I was unknowingly using a service that was costing me more and providing me less. 

## Win for UI, Huge loss for UX

### Classic vs New
There are two types of ways of interacting with Azure; on the portal it is the classic way or the new way and on the CLI it is the Azure Service (ASM) and Resource (ARM) managers. It was very difficult to work out why there were two, what they were used for and whether or not instructions in one would work in the other. There are lots of guides written for the old/ASM way which aren't applicable in the new/ARM way. I still don't really know but just use the new one for everything.

### The portal is woefully weak
Sure it looks nice but the portal is almost useless. To create a cluster I had to *manually* add every single machine and then attach every single disk to every single machine. Considering even openstack allows you to just change the number of instances from 1 to n its just not good enough. Luckily the CLI is actually quite good and has many different client languages. Unfortunately that didn't help us when we just wanted to quickly spin up 12 machines that all looked the same in less than 3 days, without having to install another tool and open up ssh ports to the cloud. Renowned for ignoring the CLI and glorifying the GUI, Microsoft swung too far the other way with this one.

### Speed is not your friend
It is slow to provision a machine. Either through the Portal or the UI. On the order of 10min for a box and 2 min for each machine. I couldn't work out how to do either in parallel. It also gives no feedback, just sits there telling you its working, trust me. 
On the up-side, there's a number of opportunities for tea breaks. 

### Cloning is difficult (maybe impossible)
Cloning is so simple in all the other tools I've used. Just click 'make more like this' - simple. Not so here. I burned through so much time trying to work out how to do this. Eventually found out it wasn't possible through the Portal. Then burnt a similar amount of time trying to use the CLI.
I still haven't managed to clone a machine. From what I have read, the steps involved:
1. Move anything off the target machine (the following steps make it non-bootable)
2. Run random script on node to make it into a template (no longer bootable)
3. Register as template to be cloned from
4. Somehow use that template to generate more machines.

Even after all that you probably still have to go through the awful creation steps above anyway. Why is it so hard?

### Sign up page is full of annoyances
The sign up steps were pretty frustrating also but nothing major. My main issues were with usability glitches like making me type the same phone number three times for no apparent reason, and rejecting my address as invalid as the countries of the address and credit card didn't match only to then be OK when I entered a garbage address. 
I mean if for some reason required (hint: it isn't) then make it required. Don't have a half way, only works if I enter a garbage address mess.

## OK maybe I should have known that one...
I encountered a very strange hadoop issue which manifested in many strange ways:

* Initially some of the blocks for HBase disappeared
* Then, there was an ID mismatch on the DataNodes from what looked like the NameNode being formatted
* Finally issues with Hive falling over

Turns out it was due to the mounting of the disks. When mounting the disks in /etc/fstab I had done so by linking to /dev/sd[c-j] rather than by their UUID. I'd never had an issue with this before until I found out that Azure doesn't maintain the sdX -> UUID mapping. This is probably how it works in the non-cloud world if I were to physically unplug my disks and reconnect at startup. 

## Summary
It's not worth it at the moment. Unless MS give you a great deal (Azure credit in place of an actual discount isn't enough) then just use AWS.
