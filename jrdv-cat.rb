require 'rubygems'
require 'sinatra'

get '/' do
  lang = 'cat'
  erb :index
end
