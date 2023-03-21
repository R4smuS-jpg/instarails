require 'rails_helper'

RSpec.describe LikesController do
  let(:user) { create(:user) }
  let(:post_1) { create(:post, user_id: user.id) }

  describe 'POST #create' do
    subject { post :create, params: { post_id: post_1.id } }

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'create like' do
        expect { subject }.to change(Like, :count).by(1)
      end

      it 'redirects to like\'s post' do
        subject
        expect(response).to redirect_to(post_1)
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'DELETE #destoy' do
    subject { delete :destroy, params: { post_id: post_1.id } }

    context 'when signed in' do
      before do
        sign_in_as(user)
        post_1.like_by(user)
      end

      it 'destroys like' do
        expect { subject }.to change(Like, :count).by(-1)
      end

      it 'redirects to like\'s post page' do
        subject
        expect(response).to redirect_to(post_1)
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
