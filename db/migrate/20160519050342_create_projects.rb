class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :sequential
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_column :tasks, :project_id, :integer
    add_index  :tasks, :project_id
  end
end
