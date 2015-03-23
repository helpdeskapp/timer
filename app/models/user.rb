class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :permissions, :dependent => :destroy

  def administrator?
    permissions.where(:role => :administrator).any?
  end
end
