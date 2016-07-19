class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

    def restrict_access
      if !current_user
        flash[:alert] = "You must log in"
        redirect_to new_session_path
      end
    end

    def admin_access
      unless current_user.admin
        flash[:alert] = "You must be admin to see this page"
        redirect_to movies_path
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user
    # Means this is available in the view classes too
end
