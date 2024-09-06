class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: %i[new create]
    def create
      @user = login(params[:email], params[:password])
  
      if @user
        redirect_to root_path
        flash[:notice] = I18n.t('user_sessions.login_success')
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def destroy
      logout
      flash[:alert] = I18n.t('user_sessions.logout_success')
      redirect_to root_path, status: :see_other, allow_other_host: true
    end
  end
