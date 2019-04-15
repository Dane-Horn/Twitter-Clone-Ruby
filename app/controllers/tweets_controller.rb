class TweetsController < ApplicationController
  #before_action :set_tweet, only: [:show, :update, :destroy]
  require 'uuidtools'
  # GET /tweets
  def create
    if authorize_request
      tweet = Tweet.new(id: UUIDTools::UUID.random_create, text: params[:text], user_id: @current_id)
      tweet.save
      render json: tweet
    else
      render status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tweet_params
      params.require(:tweet).permit(:id, :text, :user_id, :id, :tweet_id)
    end
end
