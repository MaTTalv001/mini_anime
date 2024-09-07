class FavoritesController < ApplicationController
    before_action :require_login
    
    def create
      @favorite = current_user.favorites.build(work_id: params[:work_id])
      if @favorite.save
        render json: { status: 'success', work_id: @favorite.work_id }
      else
        render json: { status: 'error', message: @favorite.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @favorite = current_user.favorites.find_by(work_id: params[:work_id])
      if @favorite&.destroy
        render json: { status: 'success', work_id: params[:work_id] }
      else
        render json: { status: 'error', message: 'お気に入りの解除に失敗しました' }, status: :unprocessable_entity
      end
    end
  end