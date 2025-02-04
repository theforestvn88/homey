require 'rails_helper'

RSpec.describe "/comments", type: :request do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:assignment) { create(:assignment, user_id: user.id, project_id: project.id) }

  let(:valid_attributes) {
    { content: "this is a comment", user: user, project: project }
  }

  let(:invalid_attributes) {
    { content: "" }
  }

  describe "GET /show" do
    it "renders a successful response" do
      comment = Comment.create! valid_attributes
      get project_comment_url(project_id: project.id, id: comment.id)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    before do
      sign_in user
    end

    it "renders a successful response" do
      get new_project_comment_url(project_id: project.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    before do
      sign_in user
    end

    it "renders a successful response" do
      comment = Comment.create! valid_attributes
      get edit_project_comment_url(project_id: project.id, id: comment.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before do
      sign_in user
    end

    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post project_comments_url(project_id: project.id), params: { comment: valid_attributes }, as: :turbo_stream
        }.to change(Comment, :count).by(1)
        expect(response).to have_http_status(200)
      end

      it "prepend new comment on top of comments list" do
        post project_comments_url(project_id: project.id), params: { comment: valid_attributes }, as: :turbo_stream
        assert_select("turbo-stream[action='prepend'][target='project_#{project.id}_comments']", 1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post project_comments_url(project_id: project.id), params: { comment: invalid_attributes }
        }.to change(Comment, :count).by(0)
      end
    
      it "not prepend any new comment" do
        post project_comments_url(project_id: project.id), params: { comment: invalid_attributes }, as: :turbo_stream
        assert_select("turbo-stream[action='prepend'][target='project_#{project.id}_comments']", 0)
      end
    end
  end

  describe "PATCH /update" do
    before do
      sign_in user
    end

    context "with valid parameters" do
      let(:new_attributes) {
        { content: "this is updated comment" }
      }

      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        patch project_comment_url(project_id: project.id, id: comment.id), params: { comment: new_attributes }, as: :turbo_stream
        expect(response).to have_http_status(200)
        comment.reload
        expect(comment.content).to eq(new_attributes[:content])
      end

      it "update the comment frame" do
        comment = Comment.create! valid_attributes
        patch project_comment_url(project_id: project.id, id: comment.id), params: { comment: new_attributes }, as: :turbo_stream
        assert_select("turbo-stream[action='replace'][target='comment_#{comment.id}']", 1)
      end
    end

    context "with invalid parameters" do
      it "not update comment frame" do
        comment = Comment.create! valid_attributes
        patch project_comment_url(project_id: project.id, id: comment.id), params: { comment: invalid_attributes }, as: :turbo_stream
        assert_select("turbo-stream[action='replace'][target='comment_#{comment.id}']", 0)
      end
    
    end
  end

  describe "DELETE /destroy" do
    before do
      sign_in user
    end

    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete project_comment_url(project_id: project.id, id: comment.id), as: :turbo_stream
      }.to change(Comment, :count).by(-1)
    end

    it "remove comment frame" do
      comment = Comment.create! valid_attributes
      delete project_comment_url(project_id: project.id, id: comment.id), as: :turbo_stream
      assert_select("turbo-stream[action='remove'][target='comment_#{comment.id}']", 1)
    end
  end
end
