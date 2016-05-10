class AddsParentToContexts < ActiveRecord::Migration
  def change
    add_column :contexts, :parent_id, :integer
    add_index  :contexts, :parent_id
  end
end
