require 'rubygems'
require 'sinatra'

get '/' do
  "Hola"
end

get '/env' do
  ENV.inspect
end