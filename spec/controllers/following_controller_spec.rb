require 'rails_helper'

RSpec.describe FollowingsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'POST #create' do
    let(:valid_following_params) { { id: other_user.id } }
    let(:invalid_following_params) { { id: 'asdasdasd' } }

    subject { post :create, params: valid_following_params }

    context 'when signed in' do
      before { sign_in_as(user) }

      context 'when following data is valid' do
        it 'creates new relationship' do
          expect { subject }.to change(Relationship, :count).by(1)
        end

        it 'redirects to followed user page' do
          subject
          expect(response).to redirect_to(other_user)
        end
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'DELETE #destroy' do 
    subject { delete :destroy, params: { id: other_user.id } }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before do
        sign_in_as(user)
        user.follow(other_user)
      end

      it 'destroys relationship' do
        expect { subject }.to change(Relationship, :count).by(-1)
      end

      it 'redirects to following user' do
        subject
        expect(response).to redirect_to(user)
      end
    end
  end
end
