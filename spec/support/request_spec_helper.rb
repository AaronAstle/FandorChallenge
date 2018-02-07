module RequestSpecHelper

  # Json parse to Ruby Hash
  def json
    JSON.parse(response.body)
  end
end
