class IpListDecorator
  def initialize(data)
    @data = data.to_a
  end

  def ip_list
    data.each_with_object([]) do |params, result|
      result << { ip_address: params['ip_address'], logins: params['string_agg'].split(';') }
    end
  end

  private

  attr_reader :data
end
