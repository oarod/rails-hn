require 'open-uri'

class StoriesController < ApplicationController
  def index
    stories = JSON.parse open('https://node-hnapi.herokuapp.com/news').read

    @stories = stories.map do |story|
      Story.new story
    end
  end

  def show
    story = JSON.parse open("https://node-hnapi.herokuapp.com/item/#{params[:id]}").read

    @story = Story.new story
  end
end
