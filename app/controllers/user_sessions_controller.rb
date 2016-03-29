class UserSessionsController < ApplicationController

 before_filter :find_id, :only=>[:edit,:update,:show,:destroy]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(allow)
    if @user_session.save
      flash[:notice] = "user log in successfully"
      redirect_to medicines_path
    else
       flash[:notice] = "error"
      redirect_to new_user_session_path
    end
  end

  def destroy
    if current_user_session.present?
      
      current_user_session.destroy
      redirect_to new_user_session_path
    end
  end

  private

  def find_id
    @user_session = UserSession.find(params[:id])
  end
  
  def allow
    params.require(:user_session).permit(:email, :password)
  end
end
