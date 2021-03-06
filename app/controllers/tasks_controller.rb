class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]
  before_action :set_contexts, except: [:index, :destroy]
  before_action :set_projects, except: [:destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @task_grouping = 'context'
    @task_groups   = set_contexts_with_tasks
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
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
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

  # GET /tasks/by_project/1
  # GET /tasks/by_project/all
  # GET /tasks/by_project/Name
  def by_project
    @task_grouping = 'project'
    case proj = params[:id]
    when /all/i
      @task_groups = Project.where(user: current_user).includes(:tasks)
    when /^\d{1,}$/
      @task_groups = Project.where(user: current_user, id: proj).includes(:tasks)
    else
      @task_groups = Project.where(user: current_user, name: proj).includes(:tasks)
    end

    respond_to do |format|
      format.html { render :index }
    end
  end

  # GET /tasks/by_context/all
  # GET /tasks/by_context/1
  # GET /tasks/by_context/Name
  def by_context
    @task_grouping = 'context'
    case ctx = params[:id]
    when /all/i
      @task_groups = set_contexts_with_tasks
    when /^\d{1,}$/
      context = Context.where(user: current_user, id: ctx).includes(:tasks).first
      @task_groups = context.children.order(:name).includes(:tasks).unshift context
    else
      context = Context.where(user: current_user, name: ctx).includes(:tasks).first
      @task_groups = context.children.order(:name).includes(:tasks).unshift context
    end

    respond_to do |format|
      format.html { render :index }
    end
  end

  # GET /tasks/toggle/1
  # GET /tasks/toggle/1.js
  def toggle
    @task.toggle! :complete
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'Status updated.' }
      format.js   { render :toggle }
    end
  end

  # DELETE /tasks/completed
  # DELETE /tasks/completed.js
  def cleanup
    Task.destroy_all(user: current_user, complete: true)
    respond_to do |format|
      format.html { redirect_to request.referer, notice: "All completed task have been removed." }
      format.js   { 'alert("All completed task have been removed.")' }
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

    # Loads set of Projects belonging to the current user.
    # The first project is the "misc" catch-all, others follow alphabetically.
    def set_projects
      misc   = Project.find_or_create_by(user: current_user, name: 'misc')
      others = Project.where(user: current_user).where.not(name: 'misc').order(:name)
      @projects = others.unshift misc
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      (params.require(:task).permit(:name,
                                    :start,
                                    :due,
                                    :project_id,
                                    :context_id,
                                    :complete,
                                    :url,
                                    :description)).merge({ user: current_user })
    end
end
