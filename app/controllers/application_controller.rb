class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  protect_from_forgery with: :exception
  before_action :set_locale
  helper_method :current_user_session, :current_user

  def set_locale
    if current_user
      I18n.locale = current_user.lang
    else
      I18n.locale = I18n.default_locale
    end
  end

  private

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def permission_denied
      flash[:danger] = t("Authorization error")
      redirect_to request.referrer || root_path
    end
end
