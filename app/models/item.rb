class Item
  include ActiveModel::Model

  attr_accessor :id, :title, :points, :user, :time, :time_ago, :type, :content, :dead, :deleted, :comments, :comments_count, :level, :url, :domain, :hash

  def initialize(attributes)
    super attributes

    self.hash = JSON.generate attributes
  end
end
