class TodoItem < ApplicationRecord
  belongs_to :todo_list
  acts_as_list scope: :todo_list

  validates :content, presence: true
  validates :content, length: {maximum: 150}
  

  def completed?
  	!completed_at.blank?
  end

end
