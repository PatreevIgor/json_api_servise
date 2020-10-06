class InfoFetcher
  def connection
    @connection ||= Connection.new.up
  end
end
