class ProjectsController < ApplicationController
  layout 'groups'
  before_action :set_project, only: [:edit, :update, :destroy]


  # GET /projects
  def index
    @projects = Project.where(user: current_user)
  end

  # GET /projects/new
  def new
    # render :edit view w/ _form
  end

  # GET /projects/1/edit
  # GET /projects/Name/edit
  def edit
    # render view w/ _form
  end

  # PUT /projects/1
  # PUT /projects/Name
  def update
    # update record
    # render index
  end

  # DELETE /projects/1
  # DELETE /projects/Name
  def destroy
    # delete record
    # render index
  end

  private
  
  def set_project
    proj = params[:id]
    case proj
    when /^d{1,}$/
      @project = Project.find proj
    else
      @project = Project.find_by_name proj 
    end
  end

end

