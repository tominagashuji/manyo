class AddColumnLimitOn < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit_on, :date, null: false, default: '19000101'
  end
end
