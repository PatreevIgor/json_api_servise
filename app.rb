require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require './services/models'
require './services/create_post_params_validator'
require './services/create_estimation_params_validator'
require './services/post_creater'
require './services/create_post_responser'
require './services/create_estimation_responser'
require './services/counter'
require './services/estimation_creater'
require 'pry'

before do
  next unless request.post?
  @request_params = JSON.parse(request.body.read, symbolize_names: true)
end

post '/create_post' do
  # if post example request: # curl -i -X POST -H "Content-Type: application/json" -d '{"login":"unic_new_login","title":"new-test-title","text":"new-test-test","ip_address":"new-author-ip"}' http://127.0.0.1:4567/create_post

  if create_post_params_validator.valid?
    user = User.find_or_create_by(login: request_params[:login])
    post_params.merge!(user_id: user.id)

    post_creator.create_post

    if post_creator.success?
      json create_post_responser.success_response
    else
      json create_post_responser.error_response
    end
  else
    json status 422
  end
end

post '/create_estimation' do
  # if post example request: # curl -i -X POST -H "Content-Type: application/json" -d '{"post_id":"20028","estimation":"5"}' http://127.0.0.1:4567/create_estimation
  if create_estimation_params_validator.valid?
    estimation_creator.create_estimation

    if estimation_creator.success?
      json create_estimation_responser.success_response
    else
      json create_estimation_responser.error_response
    end
  else
    json status 422
  end
end

get '/get_best_rate_posts' do
  # example request: http://127.0.0.1:4567/get_best_rate_posts?n=10

  json Counter.new.best_posts_post_rating_list(params[:n])
end

get '/get-ip-list' do
  # http://127.0.0.1:4567/get-ip-list

  json Counter.new.ip_list
end

private

# attr_reader does not work
def request_params
  @request_params
end

def create_estimation_params_validator
  @create_estimation_params_validator ||= CreateEstimationParamsValidator.new(request_params)
end

def create_post_params_validator
  @create_post_params_validator ||= CreatePostParamsValidator.new(request_params)
end

def create_post_responser
  @create_post_responser ||= CreatePostResponser.new(post_creator.created_post)
end

def create_estimation_responser
  @create_estimation_responser ||= CreateEstimationResponser.new(estimation_creator.created_estimation)
end

def post_creator
  @post_creator ||= PostCreater.new(request_params)
end

def estimation_creator
  @post_creator ||= EstimationCreater.new(request_params)
end
