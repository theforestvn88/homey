require "rails_helper"

RSpec.describe UpdateProjectStatus, type: :service do
    let!(:user) { create(:user) }
    let!(:project) { create(:project, user_id: user.id, status: 'pending') }

    describe "update project status" do
        subject { UpdateProjectStatus.new(project: project, user: user) }

        context "success" do
            it "change status success" do
                result = subject.update('active')
                expect(result.success).to be_truthy
                project.reload
                expect(project.active?).to be_truthy
            end

            it "create change-status comment" do
                result = subject.update('archived')
                expect(result.success).to be_truthy
                expect(result.data[:comment]).not_to be_nil
            end
        end

        context "failed" do
            it "not change project status" do
                result = subject.update('')
                expect(result.success).to be_falsy
                project.reload
                expect(project.pending?).to be_truthy
            end
        end
    end
end
