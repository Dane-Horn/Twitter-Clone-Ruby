class ApplicationController < ActionController::API
  require 'jwt'

  def authorize_request
    token = request.headers['Authorization']
    token = token[7..-1]
    begin
      decoded = JWT.decode token, 'secret'
      @current_id = decoded[0]['id']
      @current_user = User.find_by_id(@current_id)
    rescue
      return false
    end
    true
  end
end
