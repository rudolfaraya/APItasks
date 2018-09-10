class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :init, :finish, :cancel]

  # GET /tasks
  def index
    @tasks = current_user.tasks
    json_response(@tasks)
  end

  # POST /tasks
  def create
    @task = current_user.tasks.create!(task_params)
    json_response(@task, :created)
  end

  # GET /tasks/:id
  def show
    json_response(@task)
  end

  # PUT /tasks/:id
  def update
    @task.update(task_params)
    head :no_content
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy
    head :no_content
  end

  # PUT /tasks/:id/init
  def init
    @task.init!
    head :no_content
  end

  # PUT /tasks/:id/finish
  def finish
    @task.finish!
    head :no_content
  end

  # PUT /tasks/:id/cancel
  def cancel
    @task.cancel!
    head :no_content
  end

  private

  def task_params
    # whitelist params
    params.permit(:title, :state)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
