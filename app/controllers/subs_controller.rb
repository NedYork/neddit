class SubsController < ApplicationController
  before_action :ensure_user_is_mod, only: [:edit, :update]

  def create
  end

  def new
  end

  def index
  end

  def edit
    # Write an edit route where the moderator is allowed to update the title and description.
    # Use a before_action to prohibit non-moderators from editing or updating the Sub.

    @sub = Sub.find(params[:id])
    render :edit
  end

  def show
  end

  def update
  end

  private

  def ensure_user_is_mod
    current_user.is_moderator?
  end

end
