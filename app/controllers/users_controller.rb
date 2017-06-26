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
      puts '1111'
      # render :new
      render new_user_path
    end
  end

  def show
    if !current_user || current_user.id != params[:id].to_i
      flash[:danger] = "Access denied!"
      redirect_to root_path
    else
      @translations = current_user.translations.paginate(page: params[:page], :per_page => 5)
    end
  end

  def edit

  end

  private

    def users_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
