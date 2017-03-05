---
title: "Debugging Sbt Tasks in Intellij"
layout: default
date: 2017-02-13 17:08:25 GMT
---

# Debugging Sbt Tasks in Intellij
I was so lost doing this and almost reverted to print statements :O

But I didn't, here's how I got it to work.

## Edit Configs

In the top right corner of the Intellij window is a drop down. Click this and select 'Edit Configurations'

![intellij_config_location]({{ site.baseurl }}/images/intellij_config_location.png)

Add a new remote section using the '+' in the top left:

![add_remote_section_intellij]({{ site.baseurl }}/images/add_remote_section_intellij.png)

Take note of the settings section (its the only really important one for now)

![intellij_config_settings_section]({{ site.baseurl }}/images/intellij_config_settings_section.png)

Save the debug settings


## Launch SBT in debug mode

Open a terminal and start sbt in debug mode:

```
sbt -jvm-debug 5005
```

## Run the debugger

Click on the Green bug next to 'Edit Configurations' from before

![green_debugger_icon]({{ site.baseurl }}/images/green_debugger_icon.png)

## Set breakpoints and run

Set a break point in the code and run with the sbt 'test' command

