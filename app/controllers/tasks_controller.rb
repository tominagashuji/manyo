class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  before_action :set_labels, only: %i(index new edit search)
  PER = 5

  def index
    if params[:sort_expired]
      # @tasks = Task.all.order(limit_on: "DESC")
      # @tasks = Task.page(params[:page]).per(PER).limit_on_sorted
      # @tasks = Task.page(params[:page]).per(PER).limit_on_sorted
      @tasks = current_user.tasks.page(params[:page]).per(PER).limit_on_sorted
    elsif params[:sort_priority]
      # @tasks = Task.all.order(priority: "DESC")
      # @tasks = Task.page(params[:page]).per(PER).priority_sorted
      # @tasks = Task.page(params[:page]).per(PER).priority_sorted
      @tasks = current_user.tasks.page(params[:page]).per(PER).priority_sorted
    elsif
      # @tasks = Task.all.order(created_at: "DESC")
      # @tasks = Task.page(params[:page]).per(PER).created_at_sorted
      # @tasks = Task.page(params[:page]).per(PER).created_at_sorted
      @tasks = current_user.tasks.page(params[:page]).per(PER).created_at_sorted
    end
  end

  def new
    @task = Task.new
    @task.labels.build
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
    # Task.create(task_params)
    # redirect_to new_task_path
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
    # if params[:task][:name].present? && params[:task][:status].present?
    #   @tasks = Task.name_status_search(params[:task][:name],params[:task][:status]).page(params[:page]).per(PER)
    #   render "index"
    # elsif params[:task][:name].present?
    #   @tasks = Task.name_search(params[:task][:name]).page(params[:page]).per(PER)
    #   render "index"
    # elsif params[:task][:status].present?
    #   @tasks = Task.status_search(params[:task][:status]).page(params[:page]).per(PER)
    #   render "index"
    # elsif params[:task][:name].blank? && params[:task][:status].blank?
    #   redirect_to tasks_path, notice: t("flash.blank")
    # end

    @tasks = Task.all
    if params[:task][:name].present?
      @tasks = @tasks.name_search(params[:task][:name])
    end
    if params[:task][:status].present?
      @tasks = @tasks.status_search(params[:task][:status])
    end
    if params[:task][:label].present?
      @tasks = @tasks.label_search(params[:task][:label])
    end
    # binding.pry

    @tasks = @tasks.page(params[:page]).per(PER)
    render "index"
  end

  private

  def task_params
    params.require(:task).permit(
      :name,
      :content,
      :limit_on,
      :status,
      :priority,
      :user_id,
      label_ids:[],
      labels_attributes: %i(id name)
      )
  end

  def set_task
    # @task = Task.find(params[:id])
    @task = current_user.tasks.find(params[:id])
  end

  def set_labels
    @labels = Label.all
  end

end
