class UpdateProjectStatus
    Result = Struct.new(:success, :data, :errors)

    def initialize(project:, user:)
        @project = project
        @user = user
        @result = Result.new(false, {comment: nil}, nil)
    end

    def update(update_status)
        if validate_user_permission
            begin
                ActiveRecord::Base.transaction do
                    old_status = @project.status
                    Project.find(@project.id).lock!.update!(status: update_status)
                    @result.data[:comment] = Comment.create!(user_id: @user.id, project_id: @project.id, content: "#{@user.email} update project status from #{old_status} to #{update_status}")
                    
                    @result.success = true
                end
            rescue => e
            end
        end
        @result
    end

    private

        def validate_user_permission
            true
        end
end
