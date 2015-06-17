class AddPostingLocaleToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :posting_local, :string
  end
end
