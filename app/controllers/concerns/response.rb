module Response
  def json_response(object, status = :ok, include: {})
    render json: object, status: status, include: include, :except => [:created_at, :updated_at]
  end
end
