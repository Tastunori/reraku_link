class ApplicationController < ActionController::Base

before_action :set_current_uaser

  def set_current_uaser
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login_form")
    end
  end

  def forbit_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/users/index")
    end
  end


end
