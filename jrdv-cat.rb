require 'sinatra'
require 'sinatra/r18n'
require 'dm-core'
require 'dm-timestamps'

# DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite3://{#Dir.pwd}/info.db")
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/info.db")

class Page
  include DataMapper::Resource

  property :id,           Serial
  property :url,          String
  property :title,        String
  property :lang,         String
  property :content,      Text
  property :created_at,   DateTime
  property :updated_at,   DateTime
end

DataMapper.auto_upgrade!

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

get '/new' do
  erb :new
end

post '/create' do
  @page = Page.new(params[:page])
  if @page.save
    redirect("/#{@page.url}")
  else
    redirect('/new')
  end
end

get '/*' do
  @page = Page.first(:url => params[:splat])
  if @page
    erb(@page.content)
  else
    erb("Not Found")
  end
end
