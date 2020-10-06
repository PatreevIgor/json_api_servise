require 'spec_helper'
require './app.rb'

describe CreateEstimationParamsValidator do
  subject(:create_estimation_params_validator) { described_class.new(request_params) }

  let(:request_params) { { post_id: post.id, estimation: '1' } }

  let(:user) { User.create(login: 'new_user_login') }

  let(:post) { Post.create(title: post_title, text: post_text, ip_address: ip_address, user_id: user.id) }
  let(:post_title) { 'new-test-title' }
  let(:post_text) { 'new-test-text' }
  let(:ip_address) { 'new-author-ip' }

  describe '#valid?' do
    context 'when valid request params' do
      context 'when estimation is 1' do
        let(:estimation) { '1' }

        it { expect(subject.valid?).to be_truthy }
      end

      context 'when estimation is 5' do
        let(:estimation) { '5' }

        it { expect(subject.valid?).to be_truthy }
      end
    end

    context 'when invalid request params' do
      context 'when invalid post id' do
        let(:request_params) { { post_id: post_id, estimation: '1' } }

        context 'when post id does not exist' do
          let(:post_id) { post.id + 1 }

          it { expect(subject.valid?).to be_falsey }
        end

        context 'when post id is not a number' do
          let(:post_id) { 'not_number' }

          it { expect(subject.valid?).to be_falsey }
        end
      end

      context 'when invalid estimation' do
        let(:request_params) { { post_id: post.id, estimation: estimation } }

        context 'when estimation is not a number' do
          let(:estimation) { 'not_number' }

          it { expect(subject.valid?).to be_falsey }
        end

        context 'when estimation is not included in the valid range' do
          context 'when estimation is 6' do
            let(:estimation) { '6' }

            it { expect(subject.valid?).to be_falsey }
          end

          context 'when estimation is 0' do
            let(:estimation) { '0' }

            it { expect(subject.valid?).to be_falsey }
          end
        end
      end
    end
  end
end
