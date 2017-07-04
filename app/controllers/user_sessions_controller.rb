class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      # I18n.locale = current_user.lang
      flash[:success] = t("Welcome back!")
      redirect_to root_path
    else
      flash[:danger] = t("Wrong email or password!")
      render :new
      # redirect_to sign_in_path
    end
  end

  def destroy
    if current_user_session
      current_user_session.destroy
      flash[:success] = t("Goodbye!")
    end
    redirect_to root_path
  end

  private

    def user_session_params
      params.require(:user_session).permit(:email, :password, :remember_me, :test)
    end
end
