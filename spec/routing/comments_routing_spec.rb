require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/projects/1/comments/new").to route_to("comments#new", project_id: "1")
    end

    it "routes to #show" do
      expect(get: "/projects/1/comments/1").to route_to("comments#show", id: "1", project_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/projects/1/comments/1/edit").to route_to("comments#edit", id: "1", project_id: "1")
    end


    it "routes to #create" do
      expect(post: "/projects/1/comments").to route_to("comments#create", project_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/projects/1/comments/1").to route_to("comments#update", id: "1", project_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/projects/1/comments/1").to route_to("comments#update", id: "1", project_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/projects/1/comments/1").to route_to("comments#destroy", id: "1", project_id: "1")
    end
  end
end
