class RequestParamsValidator
  def initialize(params)
    @params = params
    @required_parameters = [:title, :text, :ip_address, :login]
  end

  def valid_params?
    required_parameters.each do |key, _val|
      return false unless params.key?(key)
    end

    true
  end

  private

  attr_reader :params, :required_parameters
end
