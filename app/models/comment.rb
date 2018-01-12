class Comment
  include ActiveModel::Model

  attr_accessor :id, :user, :time, :time_ago, :type, :content, :deleted, :dead, :comments, :comments_count, :level, :url

  def initialize(attributes)
    super attributes

    build_child_comments
  end

  private

  def build_child_comments
    return unless comments

    self.comments = comments.map do |params|
      Comment.new params
    end
  end
end
