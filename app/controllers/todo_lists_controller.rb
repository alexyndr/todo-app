class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_user

  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @user = User.find(params[:user_id])
    @todo_lists = @user.todo_lists
    #@todo_lists = TodoList.all
  end

  # GET /todo_lists/1
  # GET /todo_lists/1.json
  def show
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.find(params[:id])
  end

  # GET /todo_lists/new
  def new
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.new
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.create(todo_list_params)

    if @todo_list.save
      redirect_to action: 'index'
    end
  end


  # PATCH/PUT /todo_lists/1
  # PATCH/PUT /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists.find(params[:id])

    @todo_list.destroy

    redirect_to action: 'index'
  end

  private

    def check_user
      if current_user != User.find(params[:user_id])
        redirect_to root_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:title, :description)
    end
  
end
