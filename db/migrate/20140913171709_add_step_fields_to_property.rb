class AddStepFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :step_1, :boolean, default: false
    add_column :properties, :step_2, :boolean, default: false
    add_column :properties, :step_3, :boolean, default: false
    add_column :properties, :step_4, :boolean, default: false
    add_column :properties, :step_5, :boolean, default: false
  end
end
