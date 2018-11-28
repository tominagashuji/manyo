class CangeColmnNullTasks < ActiveRecord::Migration[5.2]
  change_column :tasks, :name, :string, null: false
  change_column :tasks, :content, :string, null: false
end
