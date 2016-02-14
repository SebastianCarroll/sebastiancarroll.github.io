---
layout: post
title:  "Why won't github pages work?"
date:   2016-02-14 6:10
categories: github jekyll github-pages 
---
#The Problem: GitHub pages won't display new posts after a push#
I wrote a fantastic blog yesterday and everything looked fine locally, but after a push nothing. I waited the 10 minutes and still nothing. So naturally I turned to google and of course gravitated to the first [SO post](http://stackoverflow.com/questions/20422279/github-pages-are-not-updating). I immediately reconsidered whether I should have migrated from blogspot. There were so many people having a similar issue and so many different ways they were fixed.  I thought this can't be right, there must be a way to debug this. I searched some more and found that github pages will fail with an unverified email. Apparently it will also email you if the build failed. I checked for those but only old ones from months ago. That wasn't the issue. I started just testing all the things listed in the post and anything else I could think of: 
* I've definitely pushed the code, I can see it in the commit messages. 
* I don't have the 'relative_permalinks' option in my config
* I upgraded my bundle to use jekyll 3
* I modified the index.html (One of the answerers said that helped. Can't think why)
* Checked again for relative paths, still none
* Checked I was on master
* Checked that master was still the branch to build off of
* I have no CNAME file (One answerer suggested an empty CNAME file broke it for them)
* Double checked everything worked locally
Nothing!!

Finally I remebered last time there was something weird going on with the dates. The date github reported was different to the one I had set. I also remembered that github pages can handle future posts by simply not building them if the date set is in the future. I'm in UTC+11 so if i use local time the UTC github server will think I'm posting in the future. Sure enough, changing the date to UTC and pushing showed me both my lost posts (the last one presumably because the timezones have caught up) 

#The Fix#
Use UTC for dates and the github server won't think my posts are future ones.

#Versions#
