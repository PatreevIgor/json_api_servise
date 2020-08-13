class Presenter
  def initialize(data)
    @data = data
    @result = []
  end

  def present_ip_list
    data.to_a.each { |params| result << { ip_address: params['ip_address'], logins: params['string_agg'].split(';') } }

    result
  end

  private

  attr_reader :data
  attr_accessor :result
end
