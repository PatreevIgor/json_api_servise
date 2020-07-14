class CreateEstimationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :estimations do |t|
      t.integer :value
      t.integer :post_id

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
