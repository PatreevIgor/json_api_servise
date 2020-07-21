class CreatePostParamsValidator
  include ActiveModel::Validations

  validates :title, :text, :login, :ip_address, presence: true

  def initialize(params)
    @title      = params[:title]
    @text       = params[:text]
    @login      = params[:login]
    @ip_address = params[:ip_address]
  end

  private

  attr_reader :title, :text, :login, :ip_address
end
