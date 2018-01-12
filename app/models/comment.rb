class Comment
  include ActiveModel::Model

  attr_accessor :id, :user, :time, :time_ago, :type, :content, :deleted, :dead, :comments, :comments_count, :level, :url, :hash

  def initialize(attributes)
    super attributes

    self.hash = JSON.generate attributes

    build_child_comments
  end

  def cache_key
    "comments/#{hash}"
  end

  private

  def build_child_comments
    return unless comments

    self.comments = comments.map do |params|
      Comment.new params
    end
  end
end
