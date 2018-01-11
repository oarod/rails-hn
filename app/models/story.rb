class Story
  include ActiveModel::Model

  attr_accessor :id,:title, :points, :user, :time, :time_ago, :comments_count, :type, :url, :domain
end
