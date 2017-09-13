---
title: "Migrating Rake to Thor"
layout: post
date: 2017-09-13 11:55:09 BST
---

# Migrating Rake to Thor
I spent a bit of time setting up a [Rake build-tool](https://github.com/SebastianCarroll/jekyll-rakefile) for Jekyll. It quickly morphed into something more than Rake was designed for and this quickly became apparent when I tried create new posts. The syntax was really clunky when rake was taking arguments. For example:

```
rake new_draft['Post title']
```

And the square bracket syntax is annoying and the post title must be free of commas and other reserved characters. But its one of those things that has been a bit annoying but not worth rewriting the whole thing to fix. I have recently started blogging a bit more and every time those little things nag at me so I looked into it a bit. I found this [gem of a blogpost](http://cobwwweb.com/4-ways-to-pass-arguments-to-a-rake-task) from @scdavis41 and unfortunately the options look bleak. Right at the end though Sean recommends looking at [Thor](https://github.com/erikhuda/thor) and so I did. It looks perfect! You can just inherit from `Thor` and the public methods in the class become commands. Arguments look like they get passed in as expected:

```
require "thor"
 
class MyCLI < Thor
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end
end

MyCLI.start(ARGV)
```

[Example code](http://whatisthor.com/)

Only issue with this is that now you actually have to use Ruby to run the scrip like so:

```
ruby ./cli hello Sebastian
```

Not the end of the world but those extra characters count! Shouldn't be hard to wrap in an executable bash script which just does the translation for me though

