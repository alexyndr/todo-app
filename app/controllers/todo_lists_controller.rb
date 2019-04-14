class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_user

  def index
    @user = User.find(params[:user_id])
    @todo_lists = @user.todo_lists
  end

  def show
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.new
  end

  def edit
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.find(params[:id])

    if @todo_list.update(todo_list_params)
      respond_to do |format|
        format.js
        format.html { redirect_to action: 'index', notice: 'List was updated.' }
      end
    else
      flash[:danger] = 'List cannot be empty'
    end
  end

  def create
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.create(todo_list_params)

    if @todo_list.save
      respond_to do |format|
        format.js
        format.html { redirect_to action: 'index', notice: 'List was successfully created.' }
      end
    else
      flash[:danger] = 'List cannot be empty'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.find(params[:id])

    if @todo_list.destroy
      respond_to do |format|
        format.js
        format.html { redirect_to action: 'index', notice: 'List was deleted.' }
      end
    end
  end

  private

    def check_user
      if current_user != User.find(params[:user_id])
        redirect_to root_path
      end
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def todo_list_params
      params.require(:todo_list).permit(:title)
    end
  
end
