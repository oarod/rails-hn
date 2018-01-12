require 'open-uri'

class StoriesController < ApplicationController
  def index
    @stories = Story.all(params[:category] || 'news')
  end

  def show
    @story = Story.find(params[:id])
  end
end
