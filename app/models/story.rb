class Story < Item
  API_BASE = 'https://node-hnapi.herokuapp.com'
  CACHE_EXPIRY = 5.minutes

  def self.all(category, page)
    url = "#{API_BASE}/#{category}?page=#{page}"

    Rails.cache.fetch(url, expires_in: CACHE_EXPIRY) do
      stories = JSON.parse open(url).read

      stories.map do |story|
        Story.new story
      end
    end
  end

  def self.find(id)
    url = "#{API_BASE}/item/#{id}"

    Rails.cache.fetch(url, expires_in: CACHE_EXPIRY) do
      story = JSON.parse open(url).read

      Story.new story
    end
  end

  def initialize(attributes)
    super attributes

    return unless comments

    self.comments = comments.map do |comment|
      Comment.new comment
    end
  end

  def cache_key
    "stories/#{hash}"
  end
end
