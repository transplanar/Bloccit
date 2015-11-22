require 'rails_helper'
include RandomData

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_user) {create(:user)}
  let(:my_topic) {create(:topic)}
  let(:my_post) {create(:post)}

  context "unauthenticated user" do
    it "GET show returns http success" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "PUT update returns http unauthenticated" do
      new_post = build(:post)
      put :update, topic_id: my_topic.id, id: my_post.id, post: new_post
      expect(response).to have_http_status(401)
    end

    it "POST create returns http unauthenticated" do
      # new_post = build(:post)
      # post :create, topic: { name: 'Topic Name', description: 'Topic Description' }

      post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body:RandomData.random_paragraph}
      expect(response).to have_http_status(401)
    end

    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(401)
    end
  end

  context "unauthorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "GET show returns http success" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "PUT update returns http unauthenticated" do
      new_post = build(:post)
      put :update, topic_id: my_topic.id, id: my_post.id, post: new_post
      expect(response).to have_http_status(403)
    end

    it "POST create returns http unauthenticated" do
      new_post = build(:post)
      post :create, topic_id: my_topic.id, post: new_post
      expect(response).to have_http_status(403)
    end

    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(403)
    end

  end

  context "authenticated and authorized user" do
    before do
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
      # @new_topic = build(:topic)
      @new_post = build(:post)
    end

    # it "GET show returns http success" do
    #   get :show, topic_id: my_topic.id, id: my_post.id
    #   expect(response).to have_http_status(:success)
    # end

    describe "PUT update" do

      before { put :update, topic_id: my_topic.id, id: my_post.id, post: { title: @new_post.title, body: @new_post.body } }

        # new_post = build(:post)
      # before do
        # put :update, topic_id: my_topic.id, id: my_post.id, post: new_post
        # before { put :update, topic_id: my_topic.id, id: post.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      # end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns json content type' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'updates a topic with the correct attributes' do
        updated_post = Post.find(my_post.id)
        expect(updated_post.to_json).to eq response.body
      end
    end

    # it "POST create returns http unauthenticated" do
    describe "POST create" do
      # before do
        # @new_post = build(:post)
        # post :create, topic_id: my_topic.id, post: new_post
      # end

      # >>>>>>>>>>>>>>>>>>>>>>>>>>Template
      # before { post :create, topic: { name: @new_topic.name, description: @new_topic.description } }

      # before { post :create, topic_id: my_topic.id, post: { title: @new_post.title, body: @new_post.body } }
      before { post :create, topic_id: my_topic.id, post: { title: "TEST TITLE", body: "TEST BODY TEST BODY TEST BODY " } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns json content type' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'creates a topic with the correct attributes' do
        hashed_json = JSON.parse(response.body)
        expect(@new_topic.name).to eq hashed_json['name']
        expect(@new_topic.description).to eq hashed_json['description']
      end
    end

    # desc "DELETE destroy returns http unauthenticated" do
    describe "DELETE destroy" do
      before {delete :destroy, topic_id: my_topic.id, id: my_post.id}

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "returns the correct json success message" do
        expect(response.body).to eq({"message" => "Post destroyed","status" => 200}.to_json)
      end

      it "deletes my_post" do
        expect{ Post.find(my_post.id) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
