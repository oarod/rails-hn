class Story
  include ActiveModel::Model

  API_BASE = 'https://node-hnapi.herokuapp.com'
  CACHE_EXPIRY = 5.minutes

  attr_accessor :id,:title, :points, :user, :time, :time_ago, :comments_count, :type, :url, :domain, :content, :comments, :hash

  def self.all(category, page)
    stories_url = "#{API_BASE}/#{category}?page=#{page}"

    Rails.cache.fetch(stories_url, expires_in: CACHE_EXPIRY) do
      stories = JSON.parse open(stories_url).read

      stories.map do |story|
        Story.new story
      end
    end
  end

  def self.find(id)
    story_url = "#{API_BASE}/item/#{id}"

    Rails.cache.fetch(story_url, expires_in: CACHE_EXPIRY) do
      story = JSON.parse open(story_url).read

      Story.new story
    end
  end

  def initialize(attributes)
    super attributes

    self.hash = JSON.generate attributes

    build_comments
  end

  def cache_key
    "stories/#{hash}"
  end

  private

  def build_comments
    return unless comments

    self.comments = comments.map do |params|
      Comment.new params
    end
  end
end
