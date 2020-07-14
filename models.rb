class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_one :estimation
end

class Estimation < ActiveRecord::Base
  belongs_to :post
end
