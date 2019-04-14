class HomeController < ApplicationController
  def front
  	@user = User.new
  end
end
