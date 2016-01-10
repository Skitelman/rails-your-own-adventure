class WelcomeController < ApplicationController
  def index
    @chapter = Chapter.first
  end
end
