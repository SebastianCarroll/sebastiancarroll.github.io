#!/usr/bin/ruby

require "thor"
require_relative "jekyll-rakefile/lib/jekyll_rake.rb"
require_relative "jekyll-rakefile/lib/jekyll_rake/post.rb"

class Blogger < Thor
  desc "new TITLE", "Make a new draft"
  def new(title)
    JekyllRake::Post.new(nil, Args.new(title), "_drafts/")
  end
end

# Hack class to be able to call Post.new
# as I would from the Rake file
class Args
  attr_accessor :title, :date, :content, :category

  def initialize(title)
    @title = title
  end
end

Blogger.start(ARGV)
