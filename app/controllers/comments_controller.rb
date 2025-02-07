class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :set_project
  before_action :set_comment, only: %i[ show edit update destroy ]

  rate_limit to: 3, within: 1.minute,
    by: -> { request.ip },
    only: [:create, :update]

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new(project: @project)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(user: current_user, project: @project, **comment_params)
    authorize @comment

    @comment.checksum = CommentChecksum.new.create(@comment.content)
    @comment.save
  rescue => e
    @comment.errors.add :content, :invalid, message: "Invalid"
  ensure
    respond_to do |format|
      format.turbo_stream { }
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    authorize @comment

    @comment.update(comment_params)

    respond_to do |format|
      format.turbo_stream { }
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    authorize @comment

    @comment.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Your comment was deleted." }
    end
  end

  private
    
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
