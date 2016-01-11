class Story < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
  before_save :set_slug

  def self.find_by_slug(slug)
    self.find_by(slug: slug)
  end

  private
  def set_slug
    self.slug = self.title.downcase.gsub(/[^0-9a-z ]/i, '').gsub(" ","-")
  end
end
