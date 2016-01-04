class PostsController < ApplicationController

  def create

  end

  def new

  end

  def show

  end

  def edit
    @post = Post.find(params[:id])

    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  private

  def ensure_user_is_author
    self.author_id == current_user.id
  end

  def post_params
    params.require(:post).permit(:title, :url, :author_id, :sub_id)
  end
end
