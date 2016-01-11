class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def create
    @story = Story.create(story_params)
    chapter = Chapter.create(title: "The Beginning", content: "Once upon a time ...")
    @story.chapters << chapter
    redirect_to @story
  end

  def new
    @story = Story.new
  end

  def update
    @story = Story.find(params[:id])
    @story.update(story_params)
    redirect_to @story
  end

  def edit
    @story = Story.find(params[:id])
  end

  def show
    @story = Story.find(params[:id])
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_path
  end

  private
  def story_params
    params.require(:story).permit(:title, :description)
  end
end
