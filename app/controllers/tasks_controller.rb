class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]
  before_action :set_contexts, only: [:new, :edit]

  # GET /tasks
  # GET /tasks.json
  def index
    set_contexts_with_tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.user = current_user
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /tasks/toggle/1
  # GET /tasks/toggle/1.json
  def toggle
    @task.toggle! :complete
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'Status updated.' }
      format.js   { render :toggle }
    end
  end

  private
    # Sets ivar @task to Task with param :id, belonging to Devise current_user
    def set_task
      @task = Task.where(id: params[:id], user_id: current_user.id).first
    end

    # Loads the set of Contexts belonging to the current user.
    # The first Context is the user's Inbox, others follow alphabetically.
    def set_contexts
      inbox  = Context.where(user: current_user, name: 'Inbox').first
      others = Context.where(user: current_user).where.not(name: 'Inbox').order(:name)
      @contexts = others.unshift inbox
    end

    # Same as #set_contexts, with eagerly loaded Tasks to avoid N+1 issues
    def set_contexts_with_tasks
      inbox  = Context.where(user: current_user, name: 'Inbox').includes(:tasks).first
      others = Context.where(user: current_user).where.not(name: 'Inbox').order(:name).includes(:tasks)
      @contexts = others.unshift inbox
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      (params.require(:task).permit(:name, :start, :due, :context_id, :complete)).merge({ user: current_user })
    end
end
