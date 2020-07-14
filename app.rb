require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require './servises/models'
require './servises/request_params_validator'
require './servises/counter'
require 'pry'
# require 'sinatra/param'






# Добавить валидацию на оценки принимает значение от 1 до 5
# Добавить скрипт "Скрипт должен использовать созданный JSON API сервер (можно посылать запросы курлом или еще чем-нибудь)"
# Добавить тесты для экшнов





get '/create-post' do
  # example request: # http://127.0.0.1:4567/create-post?login=unic_new_login&title=new-test-title&text=new-test-test&ip_address=new-author-ip

  if RequestParamsValidator.new(params).valid_params?
    User.create(login: params[:login]) if User.where(login: params[:login]).empty?

    json Post.create(title: params[:title], text: params[:text], ip_address: params[:ip_address])
  else
    json status 422
  end
end

get '/add-estimate-to-post' do
  # example request: http://127.0.0.1:4567/add-estimate-to-post?post_id=55&estimate=5

  Estimation.create(post_id: params[:post_id].to_i, value: params[:estimate].to_i)

  json Counter.new.average_post_rating(params[:post_id].to_i)
end

get '/get-best-rate-posts' do
  # example request: http://127.0.0.1:4567/get-best-rate-posts?n=10

  json Counter.new.best_posts_post_rating_list(params[:n])
end

get '/get-ip-list' do
  # http://127.0.0.1:4567/get-ip-list

  json Counter.new.ip_list
end
