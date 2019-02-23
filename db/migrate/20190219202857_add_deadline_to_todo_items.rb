class AddDeadlineToTodoItems < ActiveRecord::Migration[5.2]
  def change
    add_column :todo_items, :deadline, :datetime
  end
end
