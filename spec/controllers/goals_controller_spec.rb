require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  describe 'get #index' do
    it "renders user's goal index" do
      get :index, user_id: 1
      expect(response).to render_template("index")
    end
  end

  describe 'get #new' do
    it "renders new goal form" do
      get :new, user_id: 1
      expect(response).to render_template("new")
    end
  end

  describe 'get #show' do
    it "renders goal page" do
      get :show, user_id: 1
      expect(response).to render_template("show")
    end
  end

  describe 'post #create' do
    it "creates a goal with valid parameters" do
      post :create, {id: 1, goal: { name: 'Loose weight', user_id: 1 }}
      expect(Goal.last).to eq(goal)
      expect(response).to redirect_to("user_goals_url(1)")
    end

    it "does not create a goal with invalid parameters" do
      post :create, goal: { }
      expect(Goal.last).not_to eq(goal)
      expect(flash(:errors)).to be_present
      expect(response).to render_template("new")
    end

    it "does not allow user to create a goal for another user" do
      login("JonSnow")
      post :create, goal: { user_id: 1 }
      expect(Goal.last).not_to eq(goal)
      expect(response).to render_template("new")
    end
  end

  describe 'post #update' do
    it "updates a goal with valid parameters" do
      Goal.create(name: "Learn Ruby", user_id: 1)
      gid = Goal.last.id
      post :patch, goal: { id: gid, name: 'Learn Python', user_id: 1, gstatus: "private", completed: false }
      expect(Goal.last.name).to eq("Learn Python")
      expect(response).to redirect_to("user_goals_url(1)")
    end
  end

  describe 'post #destroy' do
    it "deletes a goal" do
      Goal.create(name: "Learn Ruby", user_id: 1)
      gid = Goal.last.id
      post :delete, goal: { id: gid }
      expect(Goal.find_by(id: gid)).to eq(nil)
      expect(response).to redirect_to("user_goals_url(1)")
    end
  end



end
