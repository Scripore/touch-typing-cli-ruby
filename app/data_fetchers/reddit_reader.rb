require 'json'
require 'rest_client'
require 'pry'

class RedditReader

  attr_accessor :url, :posts

  def initialize(url)
    @url = url
  end

  def read!
    @posts = []
    @reddit_hash = JSON.parse(RestClient.get(url))

    @reddit_hash['data']['children'].each do |post|
      post_url = post['data']['url'] # this one has to be first.
      post = post['data']['title'] # reassigns to var post.

      post = post.slice(4..-1)
      post.delete!(':')
      if post.chars[0] == ' '
        post = post.chars
        post.shift
        post = post.join('')
      end

      post.gsub!("’", "'")
      post.gsub!("–", "-")

      @posts << [post, post_url]
      end
    @posts
  end

  def generate_html(txt_file)
    File.open(txt_file, 'w') { |file| file.write(@posts) }
  end

end