module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def jsonapi
    j = json
    if j['data'].is_a?(Array)
      j['data'].map do |x|
        ActiveModelSerializers::Deserialization.jsonapi_parse!({ 'data' => x }).stringify_keys
      end
    else
      ActiveModelSerializers::Deserialization.jsonapi_parse!(j).stringify_keys
    end
  end
end
