class CreateEstimationParamsValidator
  include ActiveModel::Validations

  validates :post_id, :estimation, presence: true

  def initialize(params)
    @post_id = params[:post_id]
    @estimation = params[:estimation]
  end

  private

  attr_reader :post_id, :estimation
end
