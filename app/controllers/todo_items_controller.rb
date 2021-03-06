class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create, :new]

	def new
		@todo_item = @todo_list.todo_items.new
	end

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		if @todo_item
			respond_to do |format|
	        format.js
	        format.html { redirect_to action: 'index', notice: 'Item was created.' }
	    end
	  else
     flash[:danger] = 'Item cannot be empty'
    end
	end

	def move_up
  	if @todo_item.move_higher
  		respond_to do |format|
        format.js
        format.html { redirect_to action: 'index' }
    	end
		end
	end

	def move_down
  	if @todo_item.move_lower
  	respond_to do |format|
        format.js
        format.html { redirect_to action: 'index' }
    	end
		end
	end

	def destroy
		if @todo_item.destroy
			respond_to do |format|
        format.js
        format.html { redirect_to action: 'index', notice: 'Item was deleted.' }
    	end
		end
	end

	def edit
  end

  def update
    if @todo_item.update(todo_item_params)
    	if @todo_item[:deadline] != nil
	    	if @todo_item[:deadline] < DateTime.now
					@todo_item.update_attribute(:completed_at, DateTime.now)
				else
					@todo_item.update_attribute(:completed_at, nil)
				end
	    end
	      respond_to do |format|
	        format.js
	        format.html { redirect_to action: 'index', notice: 'Item was updated.' }
	    	end
    else
     flash[:danger] = 'Item cannot be empty'
    end
  end

	def complete
		if @todo_item.completed?
			@todo_item.update_attribute(:completed_at, nil)
			@todo_item.update_attribute(:deadline, nil)
		else
			@todo_item.update_attribute(:completed_at, DateTime.now)
		end
		respond_to do |format|
        format.js
        format.html { redirect_to action: 'index', notice: 'Item was updated.' }
    end
	end

	private

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end

	def set_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id])
	end

	def todo_item_params
		params.require(:todo_item).permit(:deadline, :content)
	end
end
