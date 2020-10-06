# require 'pry'
require 'sinatra/reloader'
# require './servises/connection.rb'

class PostsInfoFetcher < InfoFetcher
  def average_post_rating(post_id)
    connection.exec("SELECT posts.title, AVG(estimations.value)
                     FROM estimations
                     JOIN posts
                     ON posts.id = estimations.post_id
                     WHERE posts.id = #{post_id}
                     GROUP BY posts.title;")
  end

  def best_posts_post_rating_list(n)
    connection.exec("SELECT posts.title, AVG(estimations.value)
                     FROM estimations
                     JOIN posts ON posts.id = estimations.post_id
                     GROUP BY posts.title
                     ORDER BY AVG(estimations.value)
                     DESC LIMIT #{n};")
  end

  def ip_list
    connection.exec("SELECT posts.ip_address,
                     STRING_AGG(DISTINCT users.login, ';')
                     FROM posts
                     JOIN users
                     ON posts.user_id = users.id
                     GROUP BY posts.ip_address
                     HAVING count(DISTINCT users.login) > 1;")
  end
end
