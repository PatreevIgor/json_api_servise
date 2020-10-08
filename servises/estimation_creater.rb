class EstimationCreater
  def initialize(params)
    @post_id = params[:post_id]
    @estimation = params[:estimation]

    reset_pk_sequence
  end

  def create_estimation
    Estimation.create(post_id: post_id.to_i, value: estimation.to_i)
  end

  private

  attr_reader :post_id, :estimation

  def reset_pk_sequence
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
  end
end
