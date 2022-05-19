class ApplicationController < ActionController::Base

    skip_before_action :verify_authenticity_token

    helper_method :login!, :logged_in?, :current_user,     
                :authorized_user?, :logout!, :set_user
    before_action :current_user
    def login!
        session[:user_id] = @user.id
    end

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def validate_user
        @current_user = User.find(session[:user_id]) if session[:user_id]
        if @current_user.nil?
            render json:{error: "Not logged in"}, status: :unauthorized
            return false
        end
    end

    def validate_admin
        @current_user = User.find(session[:user_id]) if session[:user_id]
        if @current_user.nil?
            render json:{error: "Not logged in"}, status: :unauthorized
            return false
        end
        if @current_user.user_type == "Student"
            render json:{error: "Not authorized"}, status: :unauthorized
            return false
        end
    end

    def authorized_user?
        @user == current_user
    end

    def logout!
        session.clear
    end

    def set_user
        @user = User.find_by(id: session[:user_id])
    end

end
