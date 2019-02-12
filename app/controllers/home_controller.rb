class HomeController < ApplicationController
  def front
  	@user = User.new
  		#redirect_to :controller => 'todo_lists', :action => 'index'
  		#render "todo_lists/index"
  end
end
