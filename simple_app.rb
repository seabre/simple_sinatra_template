require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'dm-migrations'
require 'logger'

# Database config.
configure :development do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'simple_app' ,
    :password => 'simple_app',
    :database => 'simple_app_development'})  

  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do

  #For non PaaS deploys.
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => '' ,
    :password => '',
    :database => 'simple_app_production'})  
end

# Example Model.
#class Card
#  include DataMapper::Resource
#  property :id,         Serial
#  property :to_whom,    Text, :required => true
#  property :card_text,  Text, :required => true
#  property :random_key, Text, :unique => true, :required => true
#
#end

#Fix this.
#DataMapper.auto_upgrade!

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

get '/' do
  erb :index
end
