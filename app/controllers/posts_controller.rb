class PostsController < ApplicationController

  before_action :ensure_user_is_author, only: [:edit, :update]


  # Edit your 'Post' new/edit views to allow the user to select multiple Subs via checkboxes
  #
  # Structure your HTML form to upload an array of sub_ids nested under post
  # Update the PostsController#post_params to accept an array of sub_ids


  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_ids = post_params[:sub_ids]

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    @sub_id = params[:sub_id]
    render :new
  end

  def show
    @post = Post.find(params[:id])
    @post.top_level_comments
    render :show
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
    post = Post.find(params[:id])
    post.author_id == current_user.id
  end

  def post_params
    params.require(:post).permit(:title, :url, :author_id, sub_ids: [])
  end
end
