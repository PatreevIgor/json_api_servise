require 'spec_helper'
require './app.rb'

describe Counter do
  subject(:counter) { described_class.new }

  describe '#average_post_rating' do
    let(:expected_result) { [{ 'title' => 'some_title', 'avg' => '2.0000000000000000' }] }

    it 'returns average post rating' do
      post = Post.create(title: 'some_title')

      Estimation.create(post_id: post.id, value: 1)
      Estimation.create(post_id: post.id, value: 2)
      Estimation.create(post_id: post.id, value: 3)

      expect(counter.average_post_rating(post.id).to_a).to eq(expected_result)
    end
  end

  describe '#best_posts_post_rating_list' do
    let(:expected_result) do
      [{ 'avg' => '4.5000000000000000', 'title' => 'some_title_3' },
       { 'avg' => '3.5000000000000000', 'title' => 'some_title_2' }]
    end

    it 'returns best posts post rating list' do
      post1 = Post.create(title: 'some_title_1')
      post2 = Post.create(title: 'some_title_2')
      post3 = Post.create(title: 'some_title_3')

      Estimation.create(post_id: post1.id, value: 1)
      Estimation.create(post_id: post1.id, value: 2)

      Estimation.create(post_id: post2.id, value: 3)
      Estimation.create(post_id: post2.id, value: 4)

      Estimation.create(post_id: post3.id, value: 4)
      Estimation.create(post_id: post3.id, value: 5)

      expect(counter.best_posts_post_rating_list(2).to_a).to eq(expected_result)
    end
  end

  describe '#ip_list' do
    # Получить список айпи, с которых постило несколько разных авторов.
    # Массив объектов с полями: айпи и массив логинов авторов.

    let(:expected_result) do
      [{ 'ip_address' => '1.1.1.1', 'string_agg' => 'user_1;user_2' },
       { 'ip_address' => '1.1.1.2', 'string_agg' => 'user_1;user_2' }]
    end

    before do
      User.delete_all
      Post.delete_all
    end

    user1 = User.create(login: 'user_1')
    user2 = User.create(login: 'user_2')
    user3 = User.create(login: 'user_3')

    Post.create(title: 'new_title_1', ip_address: '1.1.1.1', user_id: user1.id)
    Post.create(title: 'new_title_2', ip_address: '1.1.1.1', user_id: user2.id)
    Post.create(title: 'new_title_3', ip_address: '1.1.1.2', user_id: user1.id)
    Post.create(title: 'new_title_4', ip_address: '1.1.1.2', user_id: user2.id)
    Post.create(title: 'new_title_5', ip_address: '1.1.1.3', user_id: user3.id)

    it 'returns ip list' do
      expect(counter.ip_list.to_a).to eq(expected_result)
    end
  end
end

# `
# Доработать: 


# 2. почему создание поста это гет?  get '/create-post

#   должно быть пост

#   add-estimate-to-post тоже самое

#   ну и что за тире в урле?

#   кароче рест архитектуры нету

#   RequestParamsValidator почему только в 1 экшене?


# User.where(login: params[:login]).empty? - есть вроде метод exist? который более быстрый, но нужно проверить точно
# есть вроде еще find_or_create



# ну я бы написал так:
# post '/posts/' do
#   if create_post_request_params_validator.valid?
#     post_creator.create_post

#     if post_creator.success?
#       json success_response(post_creator.created_post)
#     else
#       json error_response(post_creator.error)
#     end
#   else
#     json error_response(create_post_request_params_validator.error)
#   end
# end




# кароч нужен сервис обджект

# внутри которого будет создание и прочее

# а не явно из экшена




# servises  - services

# почему все модели в 1 файле?

# должна быть папка models


# Counter херовое нахвание


# @required_parameters = [:title, :text, :ip_address, :login] - это ж в константе должно быть

# ну и валидации нормальные должны быть а не просто проверка на наличие

# эктив модел валидайшн




# attr_reader :params - должно быть публичным так как ты из вне параметры передаешь

# average_post_rating оно в норм виде конвертится в джейсон? есть пример?

# должен быть джейсон:
# [
# {ip: "11.11.11.11", logins: ["gopa1", "gopa2", ...]},
# {ip: "22.22.22.22", logins: ["zalupa1", "zalupa2", ...]},
# ...
# ]


# bulk import 
# 1. Проверить на скорость
# `
