class PostsController < ApplicationController


  def index
    @tags = ActsAsTaggableOn::Tag.all

    if params[:tag_list]
     @posts = Post.tagged_with("#{params[:tag_list]}")
   else
     @posts = Post.all
   end
  end

  def new_post
    @post = @current_user.posts.build(content: params[:content], tag_list: params[:tag_list])
    if @post.save
     flash[:success] = "投稿できました"
     redirect_to("/posts/index")
   else
    redirect_to("/posts/create")
   end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/users/#{@current_user.id}")
  end

end
