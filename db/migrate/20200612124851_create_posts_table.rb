class CreatePostsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.text :ip_address
      t.integer :user_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
