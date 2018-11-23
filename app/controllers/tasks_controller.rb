class TasksController < ApplicationController
  before_action :set_task, only:[:show,:edit,:update,:destroy]

  def index
    @tasks = Task.all.order(created_at: "DESC")
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
    redirect_to new_task_path
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path, notice: "タスク編集済み"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスク削除済み"
  end

  private

  def task_params
    params.require(:task).permit(:name,:content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
