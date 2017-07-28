require 'rails_helper'

describe User do

  user = FactoryGirl.build(:user)

  describe "validations" do
    subject { FactoryGirl.build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should be_valid }
  end

  describe "has_many associations" do
    it { should have_many :permissions }
    it { should have_many :timers }
  end

  describe '#administrator?' do
    let(:user) { create(:user) }

    it 'user should not be administrator' do
      expect(user.administrator?).to eq false
    end
  end

  describe '#remember_me' do
    let(:user) { create(:user) }

    it 'user remember_me should be true' do
      expect(user.remember_me).to be_truthy
    end
  end
end
