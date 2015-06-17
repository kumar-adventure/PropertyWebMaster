class RenameSizeInProperty < ActiveRecord::Migration
  def change
    rename_column :properties, :size, :saleable_area
  end
end
