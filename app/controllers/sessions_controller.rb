class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user[:password]==params[:session][:password]
      sign_in user
      flash[:success] = "Welcome "+user.name+", pleasure for your using!"
                             #"欢迎尊敬的"+@user.name+"来到活动通，祝您使用愉快。"
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
