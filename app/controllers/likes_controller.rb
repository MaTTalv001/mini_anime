class LikesController < ApplicationController
    before_action :require_login
  
    def create
        annict_id = params[:annict_id]
        @like = current_user.likes.find_or_initialize_by(annict_id: annict_id)
      
        if @like.save
          respond_to do |format|
            format.html { redirect_back fallback_location: root_path, notice: 'いいねしました！' }
            format.turbo_stream { render turbo_stream: turbo_stream.replace("like-button-#{annict_id}", partial: 'shared/like_button', locals: { work: { 'id' => annict_id }, like: @like }) }
          end
        else
          respond_to do |format|
            format.html { redirect_back fallback_location: root_path, alert: 'いいねに失敗しました。' }
            format.turbo_stream { render turbo_stream: turbo_stream.replace("like-button-#{annict_id}", partial: 'shared/like_button', locals: { work: { 'id' => annict_id }, like: nil }) }
          end
        end
      end
      
      def destroy
        @like = current_user.likes.find(params[:id])
        annict_id = @like.annict_id
      
        if @like.destroy
          respond_to do |format|
            format.html { redirect_back fallback_location: root_path, notice: 'いいねを取り消しました。' }
            format.turbo_stream { render turbo_stream: turbo_stream.replace("like-button-#{annict_id}", partial: 'shared/like_button', locals: { work: { 'id' => annict_id }, like: nil }) }
          end
        else
          respond_to do |format|
            format.html { redirect_back fallback_location: root_path, alert: 'いいねの取り消しに失敗しました。' }
            format.turbo_stream { render turbo_stream: turbo_stream.replace("like-button-#{annict_id}", partial: 'shared/like_button', locals: { work: { 'id' => annict_id }, like: @like }) }
          end
        end
      end
  
    private
  
    def require_login
      unless current_user
        redirect_to login_path, alert: 'ログインが必要です。'
      end
    end
  end
  