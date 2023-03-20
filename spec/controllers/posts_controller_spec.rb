require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:post_1) { create(:post, user_id: user.id) }

  describe 'GET #index' do
    subject { get :index }

    context 'when not signed in' do
      it 'returns an index page' do
        subject
        expect(response).to render_template(:index)
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

  describe 'GET #likes' do
    subject { get :likes, params: { post_id: post_1.id } }

    context 'when not signed in' do
      it 'redirects to sign in path' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns a page with likes' do
        subject
        expect(response).to render_template(:likes)
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    context 'when not signed in' do
      it 'redirects to sign in path' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns new post page' do
        subject
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_post_params) do
      { post: { content: '12312312aboba',
                images: '???' } }
    end

    let(:invalid_post_params) do 
      { post: { content: '' * 300 } }
    end

    subject { post :create, params: valid_post_params }

    context 'when signed in' do
      before { sign_in_as(user) }

      context 'when post data is valid' do
        it 'creates new post' do
          posts_count_before = Post.count
          subject
          posts_count_after = Post.count

          expect(posts_count_after).to eq(posts_count_before+1)
        end

        it 'redirects to the post page' do
          subject
          expect(response).to redirect_to(Post.last)
        end
      end

      context 'when post data is not valid' do
        subject { post :create, params: invalid_post_params }

        it 'returns new post page' do
          subject

          expect(response).to render_template(:new)
        end
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in path' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: post_1.id } }

    context 'when not signed in' do
      it 'redirects to sign in path' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns new post page' do
        subject
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: post_1.id } }

    context 'when not signed in' do
      it 'redirects to sign in path' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns new post page' do
        subject
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    let(:valid_update_post_params) do
      { id: post_1.id,
        post: { content: '12312312aboba',
                images: '???' } }
    end

    let(:invalid_update_post_params) do 
      { id: post_1.id,
        post: { content: '123' * 110 } }
    end

    subject { patch :update, params: valid_update_post_params }

    context 'when signed in' do
      before { sign_in_as(user) }

      context 'when post data is valid' do
        it 'updates post post' do
          subject

          expect(response).to redirect_to(post_1)
        end
      end

      context 'when post data is not valid' do
        subject { patch :update, params: invalid_update_post_params }

        it 'returns edit post page' do
          subject

          expect(response).to render_template(:edit)
        end
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in path' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end  
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: post_1.id } }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before  { sign_in_as(user) }

      it 'destroys post in database' do
        post_1
        expect { subject }.to change(Post, :count).by(-1)
      end

      it 'redirects to root path' do
        subject
        expect(response).to redirect_to(user)
      end
    end
  end
end
