class EstimationCreater
  include ActiveModel::Validations
  attr_reader :created_estimation

  validates :post_id, :estimation, presence: true

  def initialize(params)
    @post_id = params[:post_id]
    @estimation = params[:estimation]

    reset_pk_sequence
  end

  def create_estimation
    @created_estimation = Estimation.create(post_id: post_id.to_i, value: estimation.to_i)
  end

  def success?
    errors.empty?
  end

  private

  attr_reader :post_id, :estimation, :user_id

  def reset_pk_sequence
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
  end
end
