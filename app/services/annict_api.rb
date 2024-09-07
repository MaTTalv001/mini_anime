class AnnictApi
    BASE_URL = "https://api.annict.com/v1/works"
  
    def initialize
      @access_token = ENV["ANNICT_ACCESS_TOKEN"]
    end
  
    def search_works(query, year, season)
      params = {
        fields: "id,title,title_kana,season_name_text,official_site_url,twitter_username,images",
        per_page: 20,
        access_token: @access_token
      }
      params[:filter_title] = query if query.present?
      params[:filter_season] = "#{year}-#{season}" if year.present? && season.present?
  
      response = Faraday.get(BASE_URL, params)
  
      if response.success?
        data = JSON.parse(response.body)
        data["works"]
      else
        Rails.logger.error "Annict API error: #{response.status} #{response.body}"
        []
      end
    rescue JSON::ParserError => e
      Rails.logger.error "JSON parse error: #{e.message}"
      Rails.logger.error "Response body: #{response.body}"
      []
    end


    def fetch_work(annict_id)
        params = {
          fields: "id,title,title_kana,season_name_text,official_site_url,twitter_username,images",
          access_token: @access_token,
          filter_ids: annict_id
        }
      
        response = Faraday.get(BASE_URL, params)
      
        if response.success?
          data = JSON.parse(response.body)
          work = data["works"].first  # 最初の作品を取得
          Rails.logger.info "Fetched work: #{work.inspect}"  # ログに出力
          work
        else
          Rails.logger.error "Annict API error: #{response.status} #{response.body}"
          nil
        end
      rescue JSON::ParserError => e
        Rails.logger.error "JSON parse error: #{e.message}"
        Rails.logger.error "Response body: #{response.body}"
        nil
      end
  end