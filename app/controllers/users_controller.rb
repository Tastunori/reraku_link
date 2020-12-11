class UsersController < ApplicationController

  before_action :authenticate_user,{only: [:index, :edit, :feed, :show, :profile, :show_following, :show_follower]}
  before_action :forbit_login_user,{only: [:sign_up, :login_form, ]}


  def create
    @user = User.new(
      name: params[:name],
      employee_num: params[:employee_num],
      password_digest: params[:password_digest],
      image_name: "default_img.png"
    )
    if @user.save
     flash[:notice] = "ユーザー登録が完了しました"
     redirect_to("/users/index")
     session[:user_id] = @user.id
    else
     render("users/sign_up")
    end
  end

  def login
   @user = User.find_by(
     name: params[:name],
     employee_num: params[:employee_num],
     password: params[:password]
   )
   if @user
     session[:user_id] =@user.id
     flash[:notice] = "ログインしました"
     redirect_to("/users/index")
   else
     @error_message = "ログインできませんでした"
     render("users/login_form")
   end
  end

  def index
    @users = User.all
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login_form")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @current_user.update params.require(:user).permit(:image)
   if @current_user.save
      flash[:notice] = "画像を変更しました"
      redirect_to("/users/#{@current_user.id}")
    else
      render("users/#{@user.id}/edit")
    end
  end

  def update_profile
     @current_user.update(
      store_name: params[:store_name],
      position: params[:position],
      introduce: params[:introduce]
      )
    if @current_user.save
     redirect_to("/users/#{@current_user.id}")
   else
     render("users/#{@current_user.id}/edit")
   end
  end

  def show
     @posts = @current_user.posts

  end

  def profile
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
  end


  def show_following
    @user  = User.find(params[:id])
    @users = @user.following

  end

  def show_follower
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  def feed
     following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
     @posts = Post.where("user_id IN (#{following_ids})
                      OR user_id = :user_id", user_id: @current_user.id)

   end



end
