class AddUrlToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :url, :string
  end
end
