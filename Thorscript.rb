require "thor"
require_relative "jekyll-rakefile/lib/jekyll_rake.rb"
require_relative "jekyll-rakefile/lib/jekyll_rake/post.rb"
require "pry"

class MyCLI < Thor
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end

  desc "new TITLE, CONTENT", "Make a new draft with the content provided, or edit if empty"
  def new(title, content=nil)
    JekyllRake::Post.new(nil, Args.new(title), "_drafts/")
  end
end


class Args
  attr_accessor :title, :date, :content, :category

  def initialize(title)
    @title = title
  end
end

MyCLI.start(ARGV)
