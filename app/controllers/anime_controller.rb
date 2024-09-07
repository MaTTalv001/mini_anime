class AnimeController < ApplicationController
    def search
      @years = (2000..Time.current.year).to_a.reverse
      @seasons = ['winter', 'spring', 'summer', 'autumn']
    end
  
    def results
      @query = params[:query]
      @year = params[:year]
      @season = params[:season]
      @works = fetch_works(@query, @year, @season)
    rescue StandardError => e
      Rails.logger.error "Error fetching works: #{e.message}"
      @works = []
      flash.now[:alert] = "アニメ情報の取得中にエラーが発生しました。"
    end
  
    private
  
    def fetch_works(query, year, season)
      api = AnnictApi.new
      api.search_works(query, year, season)
    end
  end