class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_user_language
  #before_filter :check_profile_completed
  before_filter :configure_devise_params, if: :devise_controller?

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def check_profile_completed
    if current_user && !current_user.profile_completed && request.get?
      render update_profile_users_path
    end
  end

  def configure_devise_params
    params[:password_confirmation] = params[:password]
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :mail_notification, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :mail_notification, :email, :password, :password_confirmation, :current_password, 
        :photo, :address, :contact_no, :about_me, :age, :highest_education, :allowing_institution, :occupation, 
        :monthly_income, :gender, :company )
    end
  end

  def set_user_language
    cookies[:language] = "zh-CN".to_sym if cookies[:language].blank?
    I18n.locale = cookies[:language] || "zh-CN".to_sym
    @current_language = cookies[:language] || "zh-CN".to_sym
  end

end
