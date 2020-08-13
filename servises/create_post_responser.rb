class CreatePostResponser
  def initialize(post)
    @post = post
  end

  def success_responce
    post
  end

  def error_responce
    post.errors.messages
  end

  private

  attr_reader :post
end
