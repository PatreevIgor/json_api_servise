require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require './models'

get '/' do
  json User.all
end
