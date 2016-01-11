class ChaptersController < ApplicationController
  def index
    @story = Story.find(params[:story_id])
    @chapters = @story.chapters
  end

  def create
    @story = Story.find(params[:story_id])
    @chapter = Chapter.create(title: params[:chapter][:title], content: params[:chapter][:content], story_id: @story.id)
    params[:chapter][:paths_attributes].values.each do |path_attributes|
        if path_attributes[:name] != ""
          path = Path.new(name: path_attributes[:name])
          @chapter.paths << path
          if path_attributes[:next_chapter_id] != ""
            path.next_chapter_id = path_attributes[:next_chapter_id]
            path.save
          elsif path_attributes[:chapter][:title] != ""
            new_chapter = Chapter.create(path_attributes[:chapter])
            path.next_chapter_id = new_chapter.id
            path.save
          else
            path.destroy
          end
        end
    end
    redirect_to [@story, @chapter]
  end

  def new
    @story = Story.find(params[:story_id])
    @chapter = Chapter.new
    4.times{@chapter.paths.build}
  end

  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update(title: params[:chapter][:title], content: params[:chapter][:content])
    path_names = params[:chapter][:paths_attributes].values.map do |path_attributes|
      if path_attributes[:name] != ""
        path  = @chapter.paths.find{|path| path.name == path_attributes[:name] } || Path.new(name: path_attributes[:name])
        @chapter.paths << path
        if path_attributes[:next_chapter_id] != ""
          path.next_chapter_id = path_attributes[:next_chapter_id]
          path.save
        elsif path_attributes[:chapter][:title] != ""
          new_chapter = Chapter.create(path_attributes[:chapter])
          path.next_chapter_id = new_chapter.id
          path.save
        else
          path.destroy
        end
      end
      path_attributes[:name]
    end
    @chapter.paths.each do |path|
      unless path_names.find{|name| path.name == name}
        @chapter.paths.delete(path)
      end
    end
    redirect_to [@chapter.story, @chapter]
  end

  def edit
    @chapter = Chapter.find(params[:id])
    (4-@chapter.paths.size).times{@chapter.paths.build}
  end

  def show
    @chapter = Chapter.find(params[:id])
  end

  def delete
    @chapter = Chapter.find(params[:id])
  end

  def destroy
    chapter = Chapter.find(params[:id])
    chapter.destroy
    redirect_to story_chapters_path(chapter.story)
  end
end
