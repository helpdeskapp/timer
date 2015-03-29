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
    if timer.active
      expect(timer.spend_time).to eq timer.amount.to_i + Time.zone.now.to_i - timer.start_at.to_time.to_i
    else
      expect(timer.spend_time).to eq timer.amount.to_i
    end
  end

  it "#parsed_time" do
    time = ['30s', '40m15s', '3h25m10s', '1h20m', '4h45s'].sample

    regex = time.match(/(?<hours>\d+(h|р))?(?<minutes>(?<=h)?\d+(m|ь))?(?<seconds>(?<=m)?\d+(s|ы))?/)

    hours   = regex[1].to_i
    minutes = regex[2].to_i
    seconds = regex[3].to_i

    expect(timer.parsed_time(time)).to eq hours * 60 * 60 + minutes * 60 + seconds
  end
end
