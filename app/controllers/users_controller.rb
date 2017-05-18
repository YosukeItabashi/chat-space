class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to :root
  end

  def search
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").where.not(name: current_user.name)
    respond_to do |format|
      format.json { render 'groups/new', json: @users }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
