class Chapter < ActiveRecord::Base
  has_many :paths, dependent: :destroy
  belongs_to :story
  accepts_nested_attributes_for :paths, allow_destroy: true

  def path_names
    self.paths.map do |path|
      path.name
    end
  end
end
