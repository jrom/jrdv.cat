require 'sinatra'
require 'sinatra/r18n'

before do

  case request.env['HTTP_HOST']
  when "jrdv.cat"
    @lang = 'ca'
  when "jrdv.es"
    @lang = 'es'
  when "jrdv.org"
    @lang = 'en'
  else
    @lang = 'ca'
  end

  session[:locale] = @lang
end

get '/' do
  @classecos = 'inici'
  erb :index
end

get %r{/(treballs|trabajos|works)} do
  @classecos = ''
  erb :treballs
end
