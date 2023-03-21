require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:post_1) { create(:post, user_id: user.id) }
  let(:comment) { create(:comment, user_id: user.id, post_id: post_1.id) }

  describe 'POST #create' do
    let(:valid_comment_params) do 
      { post_id: post_1.id,
        comment: { content: 'blah blah blah content' } }
    end
    let(:invalid_comment_params) do
      { post_id: post_1.id,
        comment: { content: 'blah' * 100 } }
    end

    subject { post :create, params: valid_comment_params }

    context 'when signed in' do
      before { sign_in_as(user) }

      context 'when comment data is valid' do
        it 'creates new comment' do
          expect { subject }.to change(Comment, :count).by(1)
        end
      end

      context 'when comment data is invalid' do
        subject { post :create, params: invalid_comment_params }

        it 'redirects to the post page' do
          subject
          expect(response).to redirect_to(comment.post)
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

  describe 'GET #edit' do
    subject { get :edit, params: { post_id: post_1.id,
                                   id: comment.id } }

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'returns edit comment page' do
        subject
        expect(response).to render_template(:edit)
      end
    end

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:valid_update_comment_params) do 
      { post_id: post_1.id,
        id: comment.id,
        comment: { content: 'blah blah blah content' } }
    end

    let(:invalid_update_comment_params) do
      { post_id: post_1.id,
        id: comment.id,
        comment: { content: 'blah' * 100 } }
    end

    subject { patch :update, params: valid_update_comment_params }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      context 'when comment data is valid' do
        # я может чего-то не понимаю, но разве аттрибут content
        # не должен меняться?(((((
        it 'updates comment' do
          expect { subject }.to change(comment, :content)
        end

        it 'redirects to comment\'s post page' do
          subject
          expect(response).to redirect_to(comment.post)
        end
      end

      context 'when comment data is invalid' do
        subject { patch :update, params: invalid_update_comment_params }

        it 'redirects to comment\'s post page' do
          subject
          expect(response).to redirect_to(comment.post)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { post_id: comment.post.id,
                                         id: comment.id } }

    context 'when not signed in' do
      it 'redirects to sign in page' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'when signed in' do
      before { sign_in_as(user) }

      it 'destroys comment' do
        comment
        expect { subject }.to change(Comment, :count).by(-1)
      end

      it 'redirects to deleted comment\'s post page' do
        subject
        expect(response).to redirect_to(comment.post)
      end
    end
  end
end
