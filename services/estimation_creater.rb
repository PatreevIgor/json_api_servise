class EstimationCreater
  include ActiveModel::Validations
  attr_reader :created_estimation

  validates :post_id, :estimate, presence: true

  def initialize(params)
    @post_id  = params[:post_id]
    @estimate = params[:estimate]
  end

  def create_estimation
    @created_estimation = Estimation.create(post_id: post_id.to_i, value: estimate.to_i)
  end

  def success?
    errors.empty?
  end

  private

  attr_reader :post_id, :estimate, :user_id
end
