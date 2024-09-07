class LikedWorksController < ApplicationController
    before_action :require_login
  
    def index
        @liked_works = []
        annict_api = AnnictApi.new
      
        current_user.likes.each do |like|
          work = annict_api.fetch_work(like.annict_id)
          if work.nil?
            Rails.logger.warn "Failed to fetch work with annict_id: #{like.annict_id}"
          else
            @liked_works << work
          end
        end
        Rails.logger.info(@liked_works)
      
        if @liked_works.empty?
          flash.now[:alert] = "いいねした作品の情報を取得できませんでした。"
        end
      end
  
    private
  
    def require_login
      unless current_user
        flash[:alert] = "ログインしてください"
        redirect_to login_path
      end
    end
  end