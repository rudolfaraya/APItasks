class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :created_by
      t.string :state, default: 'backlog'

      t.timestamps
    end
  end
end
