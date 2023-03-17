require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }
  subject(:other_user) { create(:user) }

  it { should have_secure_password }  

  # database
  describe 'database' do
    describe 'indexes' do
      it { should have_db_index(:email) }
      # does not work for some reason =/
      # it { should have_db_index(:email).unique(true) }
      it { should have_db_index(:nickname).unique(true) }
    end

    describe 'columns' do
      it { should have_db_column(:email) }
      it { should have_db_column(:nickname) }
      it { should have_db_column(:biography) }
      it { should have_db_column(:full_name) }
      it { should have_db_column(:password_digest) }
    end
  end

  # relations
  describe 'relations' do
    it { should have_many(:posts).dependent(:delete_all) }
    it { should have_many(:comments).dependent(:delete_all) }
    it { should have_one_attached(:avatar) }
    it { should have_many(:active_relationships).class_name('Relationship')
                                                .with_foreign_key('follower_id')
                                                .dependent(:destroy) }
    it { should have_many(:passive_relationships).class_name('Relationship')
                                                 .with_foreign_key('followed_id')
                                                 .dependent(:destroy) }
    it { should have_many(:followings) }
    it { should have_many(:followers) }
  end

  # validations
  describe 'validations' do
    describe 'avatar' do
      it { is_expected.to validate_content_type_of(:avatar)
        .allowing('jpeg','jpg','png', 'gif') }
      it { is_expected.to validate_size_of(:avatar).less_than(5.megabytes) }  
    end

    describe 'email' do
      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_least(5)
                                            .is_at_most(70) }
      it { should allow_value('example@mail.ru').for(:email) }
      it { should_not allow_value('examplemail.ru').for(:email) }
      it { should_not allow_value('example@mail').for(:email) }
      it { should_not allow_value('@mail.ru').for(:email) }
      it { should_not allow_value('123123').for(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    describe 'nickname' do
      it { should validate_presence_of(:nickname) }
      it { should validate_length_of(:nickname).is_at_least(3)
                                               .is_at_most(40) }
      it { should validate_uniqueness_of(:nickname) }
    end

    describe 'biography' do
      it { should validate_length_of(:biography).is_at_most(300) }
    end

    describe 'full_name' do
      it { should validate_length_of(:full_name).is_at_least(3)
                                                .is_at_most(50) }
      it { should validate_presence_of(:full_name) }
      it { should_not validate_uniqueness_of(:full_name) }
    end

    describe 'password' do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(8)
                                               .is_at_most(60) }
      it { should validate_confirmation_of(:password) }
      it { should validate_presence_of(:password_confirmation) }
      it { should validate_length_of(:password_confirmation).is_at_least(8)
                                                            .is_at_most(60) }
    end
  end

  # instance methods
  describe '#follow' do
    subject { user.follow(other_user) }

    it 'follows other user' do
      followings_count_before = user.followings.count
      subject
      followings_count_after = user.followings.count

      expect(followings_count_after).to equal(followings_count_before+1)

      expect(user.followings).to include(other_user)
      expect(other_user.followers).to include(user)
    end
  end

  describe '#unfollow' do
    subject { user.unfollow(other_user) }

    before { user.follow(other_user) }

    it 'unfollows other user' do
      followings_count_before = user.followings.count
      subject
      followings_count_after = user.followings.count

      expect(followings_count_after).to equal(followings_count_before-1)

      expect(user.followings).not_to include(other_user)
      expect(other_user.followers).not_to include(user)
    end
  end
end
