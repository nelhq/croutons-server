# frozen_string_literal: true

module GraphqlHelpers
  # rubocop:disable Metrics/PerceivedComplexity
  def parse_to_gql_input(value)
    if value.is_a? Array
      "[\n" + value.map do |h|
        parse_to_gql_input(h)
      end.join(",\n") + "\n]"
    elsif value.is_a? Hash
      "{\n" + value.map { |k, v| "#{safe_camelize(k, :lower)}: #{parse_to_gql_input(v)}" }.join("\n") + "\n}"
    elsif value.is_a? String
      value.inspect
    elsif value.is_a? Symbol
      value.to_s.inspect
    elsif value.is_a? Time
      value.iso8601.inspect
    elsif value.is_a? NilClass
      value.to_json
    else
      value
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity

  def parse_to_gql_variables(variables_hash)
    variables_hash.deep_transform_keys { |key| safe_camelize(key, :lower) }.to_json
  end

  private

  def safe_camelize(target, *options)
    string = target.to_s
    if string.first == '_'
      '_' + string.split('_').last.camelize(*options)
    else
      string.camelize(*options)
    end
  end
end

RSpec.configure do |config|
  config.include GraphqlHelpers
end
