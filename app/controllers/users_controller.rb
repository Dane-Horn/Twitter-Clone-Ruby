class UsersController < ApplicationController
  require 'jwt'
  require 'bcrypt'
  require 'uuidtools'


  #before_action :set_user, only: [:show, :update, :destroy]
  def fibo(n)
    if n < 0
      return 0
    end
    if n == 1
      return 1
    end
    fibo(n-1) + fibo(n - 2)
  end
  def comp
    render json: {message: fibo(30)}
  end
  def register
    @user = User.new(user_params)
    set_id UUIDTools::UUID.random_create
    @user.save
    render json: {message: "All done!"}
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      exp = Time.now.to_i + 60 * 3600
      payload = {id: get_id, exp: exp}
      token = JWT.encode payload, 'secret', 'HS256'
      render json: {token: token}
    else
      render status: :unauthorized
    end
  end

  def me
    if authorize_request
      render json: @current_user
    else
      render status: :unauthorized
    end
  end

  def deregister
    begin
      if authorize_request
        @current_user.destroy
        render status: :no_content
      else
        render status: :unauthorized
      end
    rescue
      render status: :unprocessable_entity
    end
  end
  
  def feed
    if authorize_request
      followees = @current_user.followees.includes(:tweets).where(tweets: {tweet_id: nil})
      result = followees.as_json(
          only: [:id, :username],
          include: [{tweets: {
              only: [:id, :text, :likes, :created_at],
              include: { replies: {
                only: [:id, :tweet_id, :text, :likes, :created_at]
              }}
          }}, :retweets]
      )
      render json: result
    else
      render status: :unauthorized
    end
  end
  
  def own_posts
    if authorize_request
      tweets = Tweet.where(user_id: @current_id)
      retweets = Retweet.where(user_id: @current_id)
      render json: {tweets: tweets, retweets: retweets}
    else
      render status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def get_email
      @user.email
    end
    def get_id
      @user.id
    end
    def set_id(value)
      @user.id = value
    end
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :email, :password, :token)
    end
end
