require "rails_helper"

RSpec.describe AssignmentsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/projects/1/assignments/new").to route_to("assignments#new", project_id: "1")
    end

    it "routes to #show" do
      expect(get: "/projects/1/assignments/1").to route_to("assignments#show", id: "1", project_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/projects/1/assignments/1/edit").to route_to("assignments#edit", id: "1", project_id: "1")
    end


    it "routes to #create" do
      expect(post: "/projects/1/assignments").to route_to("assignments#create", project_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/projects/1/assignments/1").to route_to("assignments#update", id: "1", project_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/projects/1/assignments/1").to route_to("assignments#update", id: "1", project_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/projects/1/assignments/1").to route_to("assignments#destroy", id: "1", project_id: "1")
    end
  end
end
