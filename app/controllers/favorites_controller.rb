class FavoritesController < ApplicationController
    before_action :require_login
    before_action :set_favorite, only: [:destroy]
  
    def create
      @favorite = current_user.favorites.build(work_id: params[:work_id])
      if @favorite.save
        redirect_back fallback_location: root_path, notice: 'お気に入りに追加しました'
      else
        redirect_back fallback_location: root_path, alert: 'お気に入りの追加に失敗しました'
      end
    end
  
    def destroy
        @favorite = current_user.favorites.find_by(work_id: params[:work_id])
        if @favorite&.destroy
          redirect_back fallback_location: root_path, notice: 'お気に入りを解除しました'
        else
          redirect_back fallback_location: root_path, alert: 'お気に入りの解除に失敗しました'
        end
      end
  
    def index
      @favorites = current_user.favorites
      @works = @favorites.map { |favorite| AnnictApi.new.fetch_work(favorite.work_id) }.compact
    end

    private

  def set_favorite
    @favorite = current_user.favorites.find_by(work_id: params[:work_id])
    redirect_back fallback_location: root_path, alert: 'お気に入りが見つかりません' unless @favorite
  end
  end