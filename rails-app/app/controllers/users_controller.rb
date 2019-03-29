class UsersController < ApplicationController
  def index
    response = RestClient.get('http://localhost:3002/users')
    result = JSON.parse(response.body)
    render json: result
  end
end
