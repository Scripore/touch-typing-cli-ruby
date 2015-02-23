require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

Dir["app/concerns/*.rb"].each {|f| require f}
Dir["app/models/*.rb"].each {|f| require f}
Dir["app/data_fetchers/*.rb"].each {|f| require f}
Dir["app/runners/*.rb"].each {|f| require f}

require "open-uri"
require "json"
require 'io/console'
require 'pry'
require 'pp'
require 'launchy'
require 'colorize'

# require 'pry'
# require_relative 'reddit_reader.rb'
require 'pry-nav'