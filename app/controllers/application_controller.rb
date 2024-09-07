class ApplicationController < ActionController::Base
  before_action :require_login
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  add_flash_types :success,:notice,:alert, :info, :warning, :danger

  def after_sign_in_path_for(resource)
    search_path
  end

  private

  def not_authenticated
    redirect_to login_path
  end
end
