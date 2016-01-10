class Chapter < ActiveRecord::Base
  has_many :paths
  accepts_nested_attributes_for :paths, allow_destroy: true

  def path_names
    self.paths.map do |path|
      path.name
    end
  end
end
