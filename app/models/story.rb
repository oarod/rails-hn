class Story
  include ActiveModel::Model

  attr_accessor :id,:title, :points, :user, :time, :time_ago, :comments_count, :type, :url, :domain, :content, :comments

  def self.all
    stories = JSON.parse open('https://node-hnapi.herokuapp.com/news').read

    stories.map do |story|
      Story.new story
    end
  end

  def self.find(id)
    story = JSON.parse open("https://node-hnapi.herokuapp.com/item/#{id}").read

    Story.new story
  end

  def initialize(attributes)
    super attributes

    build_comments
  end

  private

  def build_comments
    return unless comments

    self.comments = comments.map do |params|
      Comment.new params
    end
  end
end
