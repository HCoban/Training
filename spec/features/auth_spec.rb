require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before(:each) do
    visit new_user_url
  end


  scenario "has a new user page" do
    expect(page).to have_content "Sign Up"
  end
end

feature "signing up a user" do
  before(:each) do
    sign_up("Richie")
  end

  scenario "shows username on the homepage after signup" do
    expect(page).to have_content "Richie"
  end
end

feature "logging in" do
  before(:each) do
    sign_up("Halil")
    login("Halil")
  end
  scenario "shows username on the homepage after login" do
    expect(page).to have_content "Halil"
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit goals_url
    expect(page).to have_content("Sign In")
  end

  scenario "doesn't show username on the homepage after logout" do
    sign_up("Halil")
    login("Halil")
    logout
    expect(page).not_to have_content "Halil"
  end

end
