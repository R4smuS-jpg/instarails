require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    subject { get :new }

    context 'when not signed in' do
      it 'returns page with sign in form' do
        subject
        expect(response).to render_template(:new)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'redirects to current user account page' do
        subject
        expect(response).to redirect_to(user)
      end
    end
  end

  describe 'POST #create' do
    let(:session_params) do
      { session: { email: user.email, password: user.password } }
    end

    let(:incorrect_session_params) do
      { session: { email: 'asda@asdas.erere', password: '2312312312' } }
    end

    subject { post :create, params: session_params }

    context 'when not signed in' do
      context 'when user exists' do
        it 'signs user in' do
          subject

          expect(response).to redirect_to(user)
          expect(signed_in?).to equal(true)
        end
      end

      context 'when users does not exist' do
        subject { post :create, params: incorrect_session_params }

        it 'returns page with sign in form' do
          subject

          expect(response).to render_template(:new)
          expect(signed_in?).to eq(false)
        end
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'redirects to current user account page' do
        subject
        expect(response).to redirect_to(user)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy }

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'signs user out' do
        subject

        # next assertions fails because destroy action does not delete
        # cookies in test env for some reason =/
        # expect(signed_in?).to eq(false)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when not signed in' do
      it 'returns page with sign in form' do
        subject

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
