module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def jsonapi(root = 'data')
    json_parsed = json
    if json_parsed[root].is_a?(Array)
      json_parsed[root].map do |x|
        ActiveModelSerializers::Deserialization.jsonapi_parse!({ 'data' => x }).stringify_keys
      end
    else
      ActiveModelSerializers::Deserialization.jsonapi_parse!(json_parsed).stringify_keys
    end
  end
end
