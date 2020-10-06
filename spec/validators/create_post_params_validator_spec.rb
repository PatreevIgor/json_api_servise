require 'spec_helper'
require './app.rb'

describe CreatePostParamsValidator do
  subject(:create_post_params_validator) { described_class.new(request_params) }

  let(:request_params) { { login: login, title: post_title, text: post_text, ip_address: ip_address } }
  let(:login) { 'unic_new_logint' }
  let(:post_title) { 'new-test-title' }
  let(:post_text) { 'new-test-text' }
  let(:ip_address) { 'new-author-ip' }

  describe '#valid?' do
    context 'when valid request params' do
      it { expect(subject.valid?).to be_truthy }
    end

    context 'when invalid request params' do
      context 'when missing login' do
        let(:request_params) { { title: post_title, text: post_text, ip_address: ip_address } }

        it { expect(subject.valid?).to be_falsey }
      end

      context 'when missing title' do
        let(:request_params) { { login: login, text: post_text, ip_address: ip_address } }

        it { expect(subject.valid?).to be_falsey }
      end

      context 'when missing text' do
        let(:request_params) { { login: login, title: post_title, ip_address: ip_address } }

        it { expect(subject.valid?).to be_falsey }
      end

      context 'when missing ip_address' do
        let(:request_params) { { login: login, title: post_title, text: post_text } }

        it { expect(subject.valid?).to be_falsey }
      end
    end
  end
end
