class PostCreater
  include ActiveModel::Validations
  attr_reader :created_post

  validates :title, :text, :ip_address, :user_id, presence: true

  def initialize(params)
    @title      = params[:title]
    @text       = params[:text]
    @ip_address = params[:ip_address]
    @user_id    = params[:user_id]
  end

  def create_post
    @created_post = Post.create(title: title, text: text, ip_address: ip_address, user_id: user_id)
  end

  def success?
    errors.empty?
  end

  private

  attr_reader :title, :text, :ip_address, :user_id
end
