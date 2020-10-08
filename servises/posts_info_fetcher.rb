require 'pry'
require 'sinatra/reloader'

class PostsInfoFetcher
  def average_post_rating(post_id)
    connection.exec(<<-SQL.squish)
      SELECT posts.title, AVG(estimations.value)
      FROM estimations
      JOIN posts
      ON posts.id = estimations.post_id
      WHERE posts.id = #{post_id}
      GROUP BY posts.title
    SQL
  end

  def best_posts_rating_list(num)
    connection.exec(<<-SQL.squish)
      SELECT posts.title, AVG(estimations.value)
      FROM estimations
      JOIN posts ON posts.id = estimations.post_id
      GROUP BY posts.title
      ORDER BY AVG(estimations.value)
      DESC LIMIT #{num}
    SQL
  end

  def ip_list
    connection.exec(<<-SQL.squish)
      SELECT posts.ip_address,
      STRING_AGG(DISTINCT users.login, ';')
      FROM posts
      JOIN users
      ON posts.user_id = users.id
      GROUP BY posts.ip_address
      HAVING count(DISTINCT users.login) > 1
    SQL
  end

  private

  def connection
    @connection ||= Connection.new.up
  end
end
