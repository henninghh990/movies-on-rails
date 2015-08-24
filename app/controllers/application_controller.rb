class ApplicationController < ActionController::Base

	layout 'template'

 protect_from_forgery with: :exception

    def configure_permitted_parameters

      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password,:username) }

      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :username, :password, :password_confirmation) }

      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,:username) }

    end
end
