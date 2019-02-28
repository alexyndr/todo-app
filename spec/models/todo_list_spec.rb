require 'rails_helper'

RSpec.describe TodoList do
  it "cant be ampty!" do
	  todo_list = TodoList.new
	  expect (todo_list).not_to be_valid
	end

	it "title not longer than 40 symbols" do
	  todo_list = TodoList.new(title: 'a' * 41)
	  expect (todo_list).not_to be_valid
	end

	it "title not longer than 40 symbols" do
	  todo_list = TodoList.new(title: 'a' * 30)
	  expect (todo_list).to be_valid
	end
end
