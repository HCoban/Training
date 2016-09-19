require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # subject(:user) { FactoryGirl.build(:user) }
  describe "GET #new" do
    it "render the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "creates user with valid parameters" do
      post :create, user: {username: 'Richie', password: 'password123'}
      expect(User.last.username).to eq("Richie")
      expect(response).to have_http_status(302)
    end

    it "renders new with invalid parameters" do
      post :create, user: {username: 'Richie'}
      expect(flash[:errors]).to be_present
      expect(response).to render_template("new")
    end

  end


end
