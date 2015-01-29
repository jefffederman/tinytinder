class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @potential_match = @user.sample_compatible_user
  end

  private

  def user_params
    params.require(:user).permit(:login, :gender, :gender_interest, :age, :age_interest)
  end
end
