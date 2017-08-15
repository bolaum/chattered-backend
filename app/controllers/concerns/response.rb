module Response
  def json_response(object, status = :ok, include: nil, serializer: nil, each_serializer: nil)
    opts = {
      json: object,
      status: status,
      include: include,
      serializer: serializer,
      each_serializer: each_serializer
    }.compact

    render opts
  end
end
