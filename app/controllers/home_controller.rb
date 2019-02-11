class HomeController < ApplicationController
  def front
  	@user = User.new
  		#redirect_to :controller => 'todo_lists', :action => 'index'
  		#render "todo_lists/index"
  		if @user[:user_id] != nil
  			redirect_to user_todo_lists_path(current_user)
  		end
  end
end
