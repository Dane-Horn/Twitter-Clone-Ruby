class RetweetsController < ApplicationController
  #before_action :set_retweet, only: [:show, :update, :destroy]
  require 'uuidtools'
  def create
    if authorize_request
      retweet = Retweet.new(id: UUIDTools::UUID.random_create, user_id: @current_id, tweet_id: params[:id])
      retweet.save
      render json: retweet
    else
      render status: :unauthorized
    end
  end

  def destroy
    if authorize_request
      retweet = Retweet.find(params[:id])
      begin
      rescue
        return render status: :not_found
      end
      retweet.destroy
      render status: :no_content
    else
      render status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retweet
      @retweet = Retweet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def retweet_params
      params.require(:retweet).permit(:id, :references, :references)
    end
end
