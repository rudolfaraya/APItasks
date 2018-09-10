class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :init, :finish, :cancel]
  before_action :authorize_task, only: [:show, :update, :destroy, :init, :finish, :cancel]

  # GET /tasks
  def index
    if current_user.is_admin_user?
      @tasks = Task.all
      json_response(@tasks)
    else
      @tasks = current_user.tasks
      json_response(@tasks)
    end
  end

  # POST /tasks
  def create
    @task = current_user.tasks.create!(task_params)
    json_response(@task, :created)
  end

  # GET /tasks/:id
  def show
    if authorize_task
      json_response(@task)
    else
      json_response(:unauthorized_request)
    end
  end

  # PUT /tasks/:id
  def update
    if authorize_task || current_user.is_admin_user?
      @task.update(task_params)
      head :no_content
    else
      json_response(:unauthorized_request)
    end
  end

  # DELETE /tasks/:id
  def destroy
    if authorize_task || current_user.is_admin_user?
      @task.destroy
      head :no_content
    else
      json_response(:unauthorized_request)
    end

  end

  # PUT /tasks/:id/init
  def init
    if authorize_task || current_user.is_admin_user?
      @task.init!
      head :no_content
    else
      json_response(:unauthorized_request)
    end
  end

  # PUT /tasks/:id/finish
  def finish
    if authorize_task || current_user.is_admin_user?
      @task.finish!
      head :no_content
    else
      json_response(:unauthorized_request)
    end
  end

  # PUT /tasks/:id/cancel
  def cancel
    if authorize_task || current_user.is_admin_user?
      @task.cancel!
      head :no_content
    else
      json_response(:unauthorized_request)
    end
  end

  private

  def task_params
    # whitelist params
    params.permit(:title, :state)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def authorize_task
    @tasks_user = Task.select(:id).where('created_by = ?', current_user)
    if @tasks_user.include?(@task)
      true
    else
      false
    end
  end
end
