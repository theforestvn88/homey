class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_project, except: %i[ index new create ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
    load_comments
  end

  def load_more_comments
    load_comments
    
    respond_to do |format|
      format.turbo_stream {}
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /projects/1/edit_status
  def edit_status
    authorize @project
  end
  
  # PATCH /projects/1/update_status
  def update_status
    authorize @project

    respond_to do |format|
      @update_status = project_params[:status]
      @result = UpdateProjectStatus.new(project: @project, user: current_user).update(@update_status)
      format.turbo_stream {}
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, status: :see_other, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end
    
    def project_params
      params.require(:project).permit(:title, :description, :user_id, :status)
    end

    PAGE = 10
    def load_comments
      offset = params[:offset].to_i
      @comments = @project.comments.includes(:user).offset(offset).limit(PAGE)
      @next_offset = offset + PAGE unless @comments.size < PAGE
    end
end
