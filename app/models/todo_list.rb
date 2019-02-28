class TodoList < ApplicationRecord
	has_many :todo_items, :dependent => :destroy
	has_many :todo_items, -> { order(position: :asc) }
	belongs_to :user

	validates :title, presence: true
	validates :title, length: {maximum: 40}
end
