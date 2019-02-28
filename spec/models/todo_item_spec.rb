require 'rails_helper'

RSpec.describe TodoItem do
  it "cant be ampty!" do
	  todo_item = TodoItem.new
	  expect (todo_item).not_to be_valid
	end

	it "title not longer than 40 symbols" do
	  todo_item = TodoItem.new(title: 'a' * 151)
	  expect (todo_item).not_to be_valid
	end

	it "title not longer than 40 symbols" do
	  todo_item = TodoItem.new(title: 'a' * 100)
	  expect (todo_item).to be_valid
	end
end
