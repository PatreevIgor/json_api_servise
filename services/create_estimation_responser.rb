class CreateEstimationResponser
  def initialize(estimation)
    @estimation = estimation
  end

  def success_response
    counter.average_post_rating(estimation.post_id)
  end

  def error_response
    estimation.errors.messages
  end

  private

  attr_reader :estimation

  def counter
    @counter ||= Counter.new
  end
end
