require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'

enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  redirect "/items"
end

get "/items" do
  @items = Item.all
  erb :items
end

post "/items" do
  if params[:name]
    @item = Item.create({ name: params[:name] })
  end
  redirect "/items"
end
