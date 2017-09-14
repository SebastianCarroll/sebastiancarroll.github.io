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
    binding.pry
    post = JekyllRake::Post.new(title, args, "_drafts/")
    # TODO: work out how to do shell calls inside the object
    sh "vim \"#{post.file}\"" if post.content.nil?
    commit_new_content post.title, "_drafts"
  end
end

MyCLI.start(ARGV)
