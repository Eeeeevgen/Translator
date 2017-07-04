class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      render new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    authorize @user

    @translations = @user.translations.paginate(page: params[:page], :per_page => 5)
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update_attributes(users_params)
      I18n.locale = users_params[:lang]
      flash.now[:success] = t(:language_changed)
    else
      flash.now[:danger] = 'Language didn\'t updated'
    end

    render :edit
  end

  private

    def users_params
      params.require(:user).permit(:email, :password, :password_confirmation, :lang)
    end
end
