class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Timer do |timer|
      timer.user == user
    end
  end
end
