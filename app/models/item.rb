class Item
  include ActiveModel::Model

  API_BASE = 'https://hacker-news.firebaseio.com/v0'
  CACHE_EXPIRY = 1.day

  attr_accessor :id, :deleted, :type, :by, :time, :text, :dead, :parent, :poll, :kids, :url, :score, :title, :parts, :descendants, :comments, :hash

  def initialize(id)
    url = "#{API_BASE}/item/#{id}.json"

    attributes =
      Rails.cache.fetch(url, expires_in: CACHE_EXPIRY) do
        JSON.parse open(url).read
      end

    super attributes

    self.hash = JSON.generate attributes
  end
end
