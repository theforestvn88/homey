require 'rails_helper'

describe "project status", type: :system do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:assignment) { create(:assignment, user_id: user.id, project_id: project.id) }
  let!(:comment) { create(:comment, user_id: user.id, project_id: project.id) }

  before do
    driven_by(:selenium, using: :headless_chrome)

    system_test_sign_in(user.email, user.password)
    visit project_path(project)
  end

  it "update" do
    click_link("update status")

    select "Active", from: "Status"
    click_on "Update Project"

    expect(page).to have_content "Active"
  end
end
