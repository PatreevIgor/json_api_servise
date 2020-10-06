require 'spec_helper'
require './app.rb'

describe PostsInfoFetcher do
  subject(:posts_info_fetcher) { described_class.new }

  describe '#average_post_rating' do
    let(:expected_result) { [{ 'title' => 'some_title', 'avg' => '2.0000000000000000' }] }

    it 'returns average post rating' do
      post = Post.create(title: 'some_title')

      Estimation.create(post_id: post.id, value: 1)
      Estimation.create(post_id: post.id, value: 2)
      Estimation.create(post_id: post.id, value: 3)

      expect(posts_info_fetcher.average_post_rating(post.id).to_a).to eq(expected_result)
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

      expect(posts_info_fetcher.best_posts_post_rating_list(2).to_a).to eq(expected_result)
    end
  end

  describe '#ip_list' do
    let(:expected_result) do
      [{ 'ip_address' => '1.1.1.1', 'string_agg' => 'user_1;user_2' },
       { 'ip_address' => '1.1.1.2', 'string_agg' => 'user_1;user_2' }]
    end

    before do
      User.delete_all
      Post.delete_all

      user1 = User.create(login: 'user_1')
      user2 = User.create(login: 'user_2')
      user3 = User.create(login: 'user_3')

      Post.create(title: 'new_title_1', ip_address: '1.1.1.1', user_id: user1.id)
      Post.create(title: 'new_title_2', ip_address: '1.1.1.1', user_id: user2.id)
      Post.create(title: 'new_title_3', ip_address: '1.1.1.2', user_id: user1.id)
      Post.create(title: 'new_title_4', ip_address: '1.1.1.2', user_id: user2.id)
      Post.create(title: 'new_title_5', ip_address: '1.1.1.3', user_id: user3.id)
    end

    it 'returns ip list' do
      expect(posts_info_fetcher.ip_list.to_a).to eq(expected_result)
    end
  end
end
