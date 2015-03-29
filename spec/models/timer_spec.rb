require 'rails_helper'

describe Timer do

  timer = FactoryGirl.build(:timer)

  describe "validations" do
    subject { FactoryGirl.build(:timer) }

    it { should validate_presence_of(:title) }
    it { should be_valid }
  end

  it "#by_day" do
    expect(timer.start_at.to_date).to eq Time.zone.now.to_date
  end

  it "#spend_time" do
    expect(timer.spend_time).to eq timer.amount.to_i + Time.zone.now.to_i - timer.start_at.to_time.to_i
  end
end
