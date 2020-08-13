class CreateEstimationParamsValidator < ParamsValidator
  validates :post_id, :estimation, presence: true
  validate :existence_post
  validate :estimation_range
  validate :estimation_type
  validate :post_id_type

  def initialize(params)
    @post_id = params[:post_id]
    @estimation = params[:estimation]
  end

  private

  attr_reader :post_id, :estimation

  def existence_post
    return if Post.exists?(post_id)

    errors.add(:post, message: "Post does not exist: #{post_id}")
  end

  def estimation_range
    return unless estimation.to_i > 5 || estimation.to_i <= 0

    errors.add(:estimation, message: "Invalid estimation: #{estimation}, range must be 1..5")
  end

  def estimation_type
    return if estimation.integer?

    errors.add(:estimation, message: "Estimation is not a Integer: #{post_id}")
  end

  def post_id_type
    return if post_id.integer?

    errors.add(:post, message: "Post id is not a Integer: #{post_id}")
  end
end
