class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.all
  end

  def create
    @chapter = Chapter.create(title: params[:chapter][:title], content: params[:chapter][:content])
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
    redirect_to @chapter
  end

  def new
    @chapter = Chapter.new
    4.times{@chapter.paths.build}
  end

  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update(title: params[:chapter][:title], content: params[:chapter][:content])
    params[:chapter][:paths_attributes].values.each do |path_attributes|
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
    end
    redirect_to @chapter
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
    redirect_to chapters_path
  end
end
