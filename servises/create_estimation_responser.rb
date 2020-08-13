class CreateEstimationResponser
  def initialize(estimation)
    @estimation = estimation
  end

  def success_response
    average_post_rating = info_provider.average_post_rating(estimation.post_id)
  end

  def error_response
    estimation.errors.messages
  end

  private

  attr_reader :estimation

  def info_provider
    @counter ||= InfoProvider.new
  end
end
