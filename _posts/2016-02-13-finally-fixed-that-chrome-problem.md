---
layout: post
title:  "Chrome unable to restore session in Fedora 22"
date:   2016-02-13 16:51
categories: chrome selinux fedora 
---

# The Problem #
I've had this annoying problem where chrome will be be slow to load and then say it couldn't restore my last session. It was one of those problems that was never big enough to do anything about but still bugged me every time I lost my tabs. Today I finally got sick of it and googled for a fix. It was so easy, I wish I had done it sooner. 

# The Fix #
When the error reoccurred today, the AVC denial window also popped up. That gave me a pretty good idea that it was probably SELinux related. So I opened up the SELinux Troubleshooter and sure enough ```SELinux is preventing chrome-sandbox from write access on the file oom_adj.```  I then followed the advice to allow access to the file.

~~~ bash
sudo grep chrome-sandbox /var/log/audit/audit.log | audit2allow -M mypol
~~~
and install the policy. That's it! (As always, check the generated policy isn't too permissive)

After investigating further this appears to be a known bug that should be fixed in the later versions. I removed the policy and updated to v46.0.2490.80 and that seems to have fixed the error. Wait, thats the same version I started with. Well now I'm thouroughly confused, but my problem is resolved...

# Versions #
* Chrome: 46.0.2490.80
* Fedora 22
