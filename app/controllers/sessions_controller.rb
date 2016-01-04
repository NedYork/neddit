class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )

    if user.nil?
      flash[:errors] = "Incorrect username and/or password"
      render :new
    else
      login!(user)
      # redirect_to
    end

  end

  def new
    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

end
