class Timer < ActiveRecord::Base
  belongs_to :user

  extend Enumerize
  enumerize :kind, :in => [:design, :content, :copyright, :management, :develop, :not_planned_develop, :sysop, :support, :meeting], :default => :develop

  validates_presence_of :title

  scope :active, ->{ where(:active => true) }
  scope :today,  ->{ where('timers.start_at >= ? AND timers.end_at <= ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }

  def by_day
    updated_at.to_date
  end

  def spend_time
    if active?
      @spend_time = amount.to_i + Time.zone.now.to_i - start_at.to_time.to_i
    else
      @spend_time = amount.to_i
    end
  end
end
