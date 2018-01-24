class HackerNewsAPI
  API_BASE = 'https://node-hnapi.herokuapp.com'
  CACHE_EXPIRY = 5.minutes

  attr_reader :category, :page, :id

  def initialize(params)
    @category = params[:category] || 'news'
    @page = params[:page] || 1
    @id = params[:id]
  end

  def stories
    url = "#{API_BASE}/#{category}?page=#{page}"

    Rails.cache.fetch(url, expires_in: CACHE_EXPIRY) do
      stories = JSON.parse open(url).read

      stories.map do |story|
        Story.new story
      end
    end
  end

  def story
    url = "#{API_BASE}/item/#{id}"

    Rails.cache.fetch(url, expires_in: CACHE_EXPIRY) do
      story = JSON.parse open(url).read

      Story.new story
    end
  end
end
