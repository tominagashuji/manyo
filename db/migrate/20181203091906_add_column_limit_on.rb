class AddColumnLimitOn < ActiveRecord::Migration[5.2]
  add_column :tasks, :limit_on, :date
end
