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
        
        respond_to do |format|
          format.html # results.html.erbをレンダリング
          format.turbo_stream { render turbo_stream: turbo_stream.update("search-results", partial: "results") }
        end
      end
  
    private
  
    def fetch_works(query, year, season)
      api = AnnictApi.new
      api.search_works(query, year, season)
    end
  end