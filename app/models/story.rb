class Story < Item
  PER_PAGE = 10
  CACHE_EXPIRY = 5.minutes

  def self.all(category, page)
    url = "#{API_BASE}/#{get_category(category)}.json"

    story_ids =
      Rails.cache.fetch(url, expires_in: CACHE_EXPIRY) do
        JSON.parse open(url).read
      end

    page_min = PER_PAGE * (page.to_i - 1)
    page_max = PER_PAGE * page.to_i - 1

    story_ids[page_min..page_max].map do |id|
      Story.new id, false
    end
  end

  def self.find(id)
    Story.new id
  end

  def self.get_category(category)
    case category
      when 'news'
        'topstories'
      when 'newest'
        'newstories'
      when 'show'
        'showstories'
      when 'ask'
        'askstories'
      when 'jobs'
        'jobstories'
      else
        'topstories'
    end
end

  def initialize(id, comments = true)
    super id

    build_comments if comments
  end

  def cache_key
    "stories/#{hash}"
  end

  private

  def build_comments
    self.kids ||= []

    self.comments = kids.map do |id|
      Comment.new id
    end
  end
end
