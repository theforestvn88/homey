require 'rails_helper'

describe "comment", type: :system do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:assignment) { create(:assignment, user_id: user.id, project_id: project.id) }
  let!(:comment) { create(:comment, user_id: user.id, project_id: project.id) }

  before do
    driven_by(:selenium, using: :headless_chrome)

    system_test_sign_in(user.email, user.password)
    visit project_path(project)
  end

  it "add comment" do
    click_link("new comment")

    fill_in "comment[content]", with: "test comment"
    click_on "Create Comment"

    expect(page).to have_content "test comment"
  end

  it "edit comment" do
    find("#comment_#{comment.id}").hover
    click_link("edit")

    fill_in "comment[content]", with: "updated content"
    click_on "Update Comment"

    expect(page).to have_content "updated content"
  end

  it "delete comment" do
    find("#comment_#{comment.id}").hover
    click_on "delete"
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_content comment.content
  end
end
