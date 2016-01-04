class SubsController < ApplicationController
  before_action :ensure_user_is_mod, only: [:edit, :update]
  before_action :redirect_unless_logged_in, only: [:new, :create]

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new

    render :new
  end

  def index
    @subs = Sub.all

    render :index
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts


    render :show
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def ensure_user_is_mod
    current_user.is_moderator?
  end

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

end
