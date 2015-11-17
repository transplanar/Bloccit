require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_post) { create(:post, topic: my_topic, user: other_user) }
  let(:my_vote) { Vote.create!(value: 1) }

  # TODO Delete commented lines

  context 'guest' do
    describe 'POST up_vote' do
      it 'redirects the user to the sign in view' do
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe 'POST down_vote' do
      it 'redirects the user to the sign in view' do
        delete :down_vote, post_id: user_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context 'signed in user' do
    before do
      create_session(my_user)
      #TODO Is this line needed for Ajax??
      request.env['HTTP_REFERER'] = topic_post_path(my_topic, user_post)
    end

    describe 'POST up_vote' do
      it 'the users first vote increases number of post votes by one' do
        votes = user_post.votes.count
        # post :up_vote, post_id: user_post.id
        post :up_vote, format: :js, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it 'the users second vote does not increase the number of votes' do
        # post :up_vote, post_id: user_post.id
        post :up_vote, format: :js, post_id: user_post.id
        votes = user_post.votes.count
        # post :up_vote, post_id: user_post.id
        post :up_vote, format: :js, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes)
      end

      it 'increases the sum of post votes by one' do
        points = user_post.points
        # post :up_vote, post_id: user_post.id
        post :up_vote, format: :js, post_id: user_post.id
        expect(user_post.points).to eq(points + 1)
      end

      # it ':back redirects to posts show page' do
      it 'show http success on down vote from POST show view' do
        request.env['HTTP_REFERER'] = topic_post_path(my_topic, user_post)
        # post :up_vote, post_id: user_post.id
        post :up_vote, format: :js, post_id: user_post.id
        # expect(response).to redirect_to([my_topic, user_post])
        expect(response).to have_http_success(:success)
      end

      it 'show http success on down vote from TOPIC show view' do
        request.env['HTTP_REFERER'] = topic_path(my_topic)
        # post :up_vote, post_id: user_post.id
        post :up_vote, format: :js, post_id: user_post.id
        # expect(response).to redirect_to(my_topic)
        expect(response).to have_http_success(:success)
      end
    end

    describe 'POST down_vote' do
      it 'the users first vote increases number of post votes by one' do
        votes = user_post.votes.count
        # post :down_vote, post_id: user_post.id
        post :down_vote, format: :js, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it 'the users second vote does not increase the number of votes' do
        # post :down_vote, post_id: user_post.id
        post :down_vote, format: :js, post_id: user_post.id
        votes = user_post.votes.count
        # post :down_vote, post_id: user_post.id
        post :down_vote, format: :js, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes)
      end

      it 'decreases the sum of post votes by one' do
        points = user_post.points
        # post :down_vote, post_id: user_post.id
        post :down_vote, format: :js, post_id: user_post.id
        expect(user_post.points).to eq(points - 1)
      end

      # it ':back redirects to posts show page' do
      it 'show http success on down vote from post show view' do
        request.env['HTTP_REFERER'] = topic_post_path(my_topic, user_post)
        # post :down_vote, post_id: user_post.id
        post :down_vote, format: :js, post_id: user_post.id
        # expect(response).to redirect_to([my_topic, user_post])
        expect(response).to have_http_success(:success)
      end

      # it ':back redirects to posts topic show' do
      it 'return http success on down vote from topic show view' do
        request.env['HTTP_REFERER'] = topic_path(my_topic)
        # post :down_vote, post_id: user_post.id
        post :down_vote, format: :js, post_id: user_post.id
        # expect(response).to redirect_to(my_topic)
        expect(response).to have_http_success(:success)
      end
    end
  end
end
