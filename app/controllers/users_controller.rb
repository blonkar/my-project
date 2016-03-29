class UsersController < ApplicationController
  before_action :find_id, :only=>[:edit,:update,:show,:destroy]
  #before_filter :require_user, :only=>[:edit,:update,:show,:destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save(user_params)

      flash[:notice] = "user saved"
      redirect_to login_path(:id=>@user.id)
    else
      flash[:alert] = "user not save"
      redirect_to users_path(:id=>@user.id)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user created"
      redirect_to user_path(:id=>@user.id)
    else
      flash[:notice] = "Unable to update"
      redirect_to edit_user_path    
    end
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    falsh[:notice] = "User deleted"
    redirect_to users_path
  end
  private
  def find_id
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
