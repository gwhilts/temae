class AddUserIndexToContexts < ActiveRecord::Migration
  def change
    change_table :contexts do |t|
      t.index :user_id
    end
  end
end
