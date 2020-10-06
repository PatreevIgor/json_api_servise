require 'require_all'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'pry'

require_all './config/initializers'
require_all './lib/utils'
require_all './servises'
require_all './models'
require_all './decorators'
require_all './validators/params_validator.rb'
require_all './validators/'

before do
  next unless request.post?

  @request_params = JSON.parse(request.body.read, symbolize_names: true)
end

post '/create_post' do
  if create_post_params_validator.valid?
    user = User.find_or_create_by(login: request_params[:login])
    request_params.merge!(user_id: user.id)

    json post_creator.created_post
  else
    json create_post_params_validator.errors.messages, status: 422
  end
end

post '/create_estimation' do
  if create_estimation_params_validator.valid?
    estimation = estimation_creator.created_estimation

    json posts_info_fetcher.average_post_rating(estimation.post_id)
  else
    json create_estimation_params_validator.errors.messages, status: 422
  end
end

get '/get_best_rate_posts' do
  json posts_info_fetcher.best_posts_post_rating_list(params[:n])
end

get '/get-ip-list' do
  json ip_list_decorator(posts_info_fetcher.ip_list).ip_list
end

private

def request_params
  @request_params
end

def create_estimation_params_validator
  @create_estimation_params_validator ||= CreateEstimationParamsValidator.new(request_params)
end

def create_post_params_validator
  @create_post_params_validator ||= CreatePostParamsValidator.new(request_params)
end

def post_creator
  @post_creator ||= PostCreater.new(request_params)
end

def estimation_creator
  @post_creator ||= EstimationCreater.new(request_params)
end

def ip_list_decorator(data)
  @ip_list_decorator ||= IpListDecorator.new(data)
end

def posts_info_fetcher
  @posts_info_fetcher ||= PostsInfoFetcher.new
end
