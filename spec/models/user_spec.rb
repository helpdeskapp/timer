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
  end

  it "#administrator?" do
    expect(user.administrator?).to eq false
  end
end
