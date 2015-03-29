require 'faker'

FactoryGirl.define do
  sec = Faker::Number.number(5)

  factory :timer do
    title { Faker::Lorem.word }
    kind { Timer.kind.values.sample }
    active { [true, false].sample }
    amount { sec }
    start_at { Time.zone.now }
    end_at { Time.zone.now + sec.to_i.seconds }

    association :user, :factory => :user
  end
end
