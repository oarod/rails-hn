class Story < Item
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
