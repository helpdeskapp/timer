class Permission < ActiveRecord::Base
  belongs_to :user

  extend Enumerize
  enumerize :role, :in => [:administrator], :predicates => true
end
