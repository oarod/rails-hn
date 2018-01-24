require 'open-uri'

class StoriesController < ApplicationController
  def index
    @stories = HackerNewsAPI.new(story_params).stories
  end

  def show
    @story = HackerNewsAPI.new(story_params).story
  end

  private

  def story_params
    params.permit :category, :page, :id
  end
end
