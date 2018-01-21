class Comment < Item
  def initialize(id)
    super id

    build_child_comments
  end

  def cache_key
    "comments/#{hash}"
  end

  private

  def build_child_comments
    self.kids ||= []

    self.comments = kids.map do |id|
      Comment.new id
    end
  end
end
