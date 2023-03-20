require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    subject { get :index }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns an index page' do
        subject
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #followings' do
    subject { get :followings, params: { id: user.id } }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before  { sign_in_as(user) }

      it 'returns page with followings' do
        subject
        expect(response).to render_template(:followings)
      end
    end
  end

  describe 'GET #followers' do
    subject { get :followers, params: { id: user.id } }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns page with followers' do
        subject
        expect(response).to render_template(:followers)
      end
    end
  end

  describe 'GET #feed' do
    subject { get :feed }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns page with feed' do
        subject
        expect(response).to render_template(:feed)
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    context 'when not signed in' do
      it 'returns page with sign up form' do
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
    let(:user_params) do 
      { user: { email: 'user@mail.ru',
                nickname: 'aboba',
                biography: 'lorem ipsum blah blah blah',
                full_name: 'full user name',
                password: 'password123',
                password_confirmation: 'password123' } }
    end

    let(:incorrect_user_params) do
      { user: { email: 'usermailru',
                nickname: '',
                biography: 'lorem ipsum',
                full_name: '',
                password: '123',
                password_confirmation: '456' } }
    end

    subject { post :create, params: user_params }

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'redirects to current user account page' do
        subject
        expect(response).to redirect_to(user)
      end
    end

    context 'when not signed in' do
      context 'when model data is correct' do
        it 'creates new user in database' do
          users_count_before = User.count
          subject
          users_count_after = User.count
          expect(users_count_after).to eq(users_count_before+1)
        end

        it 'redirects to user page' do
          subject
          expect(response).to redirect_to(User.last) 
        end
      end

      context 'when model data is not correct' do
        it 'renders new user page' do
          post :create, params: incorrect_user_params
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET #show' do
    subject { get :show, params: {id: user.id} }

    context 'when not signed in' do
      it 'returns page with account' do
        subject
        expect(response).to render_template(:show)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns page with account' do
        subject
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: user.id } }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before  { sign_in_as(user) }

      it 'returns page with edit user form' do
        subject
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    let(:update_user_params) do
      { user: { id: user.id,
                email: user.email + 'adsdasdas',
                nickname: user.nickname + '12131231',
                biography: user.biography + 'asdasa',
                full_name: user.full_name + '1231231',
                password: user.password + '123',
                password_confirmation: user.password + '123' } }
    end

    let(:incorrect_update_user_params) do
      { user: { id: user.id,
                email: 'usermailru',
                nickname: '',
                biography: 'lorem ipsum',
                full_name: '',
                password: '123',
                password_confirmation: '456' } }
    end

    subject { patch :update, params: update_user_params }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      context 'when model data is correct' do
        it 'redirects to user page' do
          subject
          expect(response).to redirect_to(user) 
        end
      end

      context 'when model data is not correct' do
        subject { patch :update, params: incorrect_update_user_params }

        it 'renders edit user page' do
          subject
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: user.id } }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before  { sign_in_as(user) }

      it 'destroys user in database' do
        users_count_before = User.count
        subject
        users_count_after = User.count

        expect(users_count_after).to eq(users_count_before-1)
      end

      it 'redirects to root path' do
        subject
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
