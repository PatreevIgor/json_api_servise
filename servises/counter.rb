require 'pry'
require 'sinatra/reloader'

class Counter
  attr_reader :conn

  def initialize
    @conn = PG.connect(dbname: 'json_dev_api_database',
                       user: 'activebilling',
                       password: 'password',
                       port: 5432,
                       host: 'localhost')
  end

  def average_post_rating(post_id)
    conn.exec("SELECT posts.title, AVG(estimations.value)
               FROM estimations
               JOIN posts
               ON posts.id = estimations.post_id
               WHERE posts.id = #{post_id}
               GROUP BY posts.title;")
  end

  def best_posts_post_rating_list(n)
    conn.exec("SELECT posts.title, AVG(estimations.value)
               FROM estimations
               JOIN posts ON posts.id = estimations.post_id
               GROUP BY posts.title
               ORDER BY AVG(estimations.value)
               DESC LIMIT #{n};")
  end

  def ip_list
    conn.exec("SELECT posts.ip_address,
               STRING_AGG(DISTINCT users.login, ';')
               FROM posts
               JOIN users
               ON posts.user_id = users.id
               GROUP BY posts.ip_address
               HAVING count(DISTINCT users.login) > 1;")
  end
end
