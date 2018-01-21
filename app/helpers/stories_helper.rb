module StoriesHelper
  def domain(url)
    URI(url).host.gsub(/www\./, '') rescue ''
  end
end
