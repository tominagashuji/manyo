class TasksController < ApplicationController
  before_action :set_task, only:[:show,:edit,:update,:destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(limit_on: "DESC")
    else
      @tasks = Task.all.order(created_at: "DESC")
    end
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

  def search
    if params[:task][:name].present? && params[:task][:status].present?
      @tasks = Task.name_status_search(params[:task][:name],params[:task][:status])
      render "index"
    elsif params[:task][:name].present?
      @tasks = Task.name_search(params[:task][:name])
      render "index"
    elsif params[:task][:status].present?
      @tasks = Task.status_search(params[:task][:status])
      render "index"
    elsif params[:task][:name].blank? && params[:task][:status].blank?
      redirect_to tasks_path, notice: t("flash.blank")
    end
  end

  private

  def task_params
    params.require(:task).permit(:name,:content,:limit_on,:status,:priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
