class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create, :new]

	def new
		@todo_item = @todo_list.todo_items.new
	end

=begin
	def deadline
		#puts @todo_item.inspect
		@todo_item.update(todo_item_params)
		if @todo_item[:deadline] < Time.now
			@todo_item.update_attribute(:completed_at, nil)
			complete
		else
			@todo_item.update_attribute(:completed_at, Time.now)
			complete
		end
		#redirect_to user_todo_lists_path(current_user), notice: "Deadline is added"
	end
=end

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)
			respond_to do |format|
	        format.js
	        format.html { redirect_to action: 'index', notice: 'Item was created.' }
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

    @todo_item.update(todo_item_params)
    	if @todo_item[:deadline] < DateTime.now
				@todo_item.update_attribute(:completed_at, DateTime.now)
			else
				@todo_item.update_attribute(:completed_at, nil)
			end
    	respond_to do |format|
        format.js
        format.html { redirect_to action: 'index', notice: 'Item was updated.' }
      end
    	#if @todo_item[:deadline] < Time.now
				#complete
			#else
    		#redirect_to user_todo_lists_path(current_user)
 
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
