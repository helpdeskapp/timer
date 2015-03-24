class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :permissions, :dependent => :destroy
  has_many :timers, -> { order('created_at desc') } , :dependent => :destroy

  def administrator?
    permissions.where(:role => :administrator).any?
  end

  def stop_all_active_timers
    timers.active.map { |timer| timer.update_attributes(:active => false, :amount => timer.spend_time, :end_at => Time.zone.now) }
  end
end
