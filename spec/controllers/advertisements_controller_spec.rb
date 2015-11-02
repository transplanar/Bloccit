require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "insantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).to_not be_nil
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
    
    it "increases number of advertisements by 1" do
      expect{advertisement :create, advertisement: {title: "New Ad", copy: "New Ad Copy", price: 1000}}.to change(Advertisement, :count).by(1)
    end
    
    it "assigns the new advertisement to @advertisement" do
      advertisement :create, advertisement: {title: "New Ad", copy: "New Ad Copy", price: 1000}
      expect(assigns(:advertisement)).to eq Advertisement.last
    end
  end

end
