class FollowsController < ApplicationController
  #before_action :set_follow, only: [:show, :update, :destroy]

  def create
    if authorize_request
      follow = Follow.new(user_id: @current_id, followee_id: params[:id])
      follow.save
      render status: :created
    else
      render status: :unauthorized
    end
  end

  def follows
    if authorize_request
      render json: @current_user.followees
    else
      render status: :unauthorized
    end
  end

  def destroy
    if authorize_request
      begin
        follow = Follow.where(user_id: @current_id, followee_id: params[:id]).first
      rescue
        return render status: :unprocessable_entity
      end
      follow.destroy
      render status: :no_content
    else
      render status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def follow_params
      params.fetch(:follow, {})
    end
end
