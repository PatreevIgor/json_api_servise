require 'spec_helper'
require './app.rb'

describe Counter do
  # subject(:decorator) { described_class.new(account_class) }
  # let(:account_class) { create(:account_class) }

  describe '#average_post_rating' do
    it 'returns average post rating' do
      post = Post.create(title: 'some_title')

      Estimation.create(post_id: post.id, value: 1)
      Estimation.create(post_id: post.id, value: 2)
      Estimation.create(post_id: post.id, value: 3)

      expect(Counter.new.average_post_rating(post.id).to_a).to eq([{ 'title' => 'some_title',
                                                                     'avg' => '2.0000000000000000' }])
    end
  end

  describe '#best_posts_post_rating_list' do
    it 'returns best posts post rating list' do
    end
  end

  describe '#ip_list' do
    it 'returns ip list' do
    end
  end
end
