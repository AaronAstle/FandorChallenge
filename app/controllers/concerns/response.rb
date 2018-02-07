module Response
  def json_response(object, status = :ok)
    # Set status to ok unless specified
    render json: object, status: status
  end
end
