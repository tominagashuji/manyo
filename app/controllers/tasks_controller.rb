class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  PER = 5

  def index
    if params[:sort_expired]
      # @tasks = Task.all.order(limit_on: "DESC")
      # @tasks = Task.page(params[:page]).per(PER).limit_on_sorted
      @tasks = Task.page(params[:page]).per(PER).limit_on_sorted
    elsif params[:sort_priority]
      # @tasks = Task.all.order(priority: "DESC")
      # @tasks = Task.page(params[:page]).per(PER).priority_sorted
      @tasks = Task.page(params[:page]).per(PER).priority_sorted
    elsif
      # @tasks = Task.all.order(created_at: "DESC")
      # @tasks = Task.page(params[:page]).per(PER).created_at_sorted
      @tasks = Task.page(params[:page]).per(PER).created_at_sorted
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
      @tasks = Task.name_status_search(params[:task][:name],params[:task][:status]).page(params[:page]).per(PER)
      render "index"
    elsif params[:task][:name].present?
      @tasks = Task.name_search(params[:task][:name]).page(params[:page]).per(PER)
      render "index"
    elsif params[:task][:status].present?
      @tasks = Task.status_search(params[:task][:status]).page(params[:page]).per(PER)
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
