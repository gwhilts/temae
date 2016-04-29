class AddContextIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :context_id, :integer
    add_index  :tasks, :context_id
  end
end
