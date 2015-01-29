class LikesController < ApplicationController
  before_filter :get_users, only: [:create, :destroy]

  def create
    @user.liked_users << @match
    redirect_to @user
  end

  def destroy
    @user.rejected_users << @match
    redirect_to @user
  end

  private

  def get_users
    @user = User.find(params[:id])
    @match = User.find(params[:match_id])
  end
end
