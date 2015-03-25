class Timer < ActiveRecord::Base
  attr_accessor :time, :date

  belongs_to :user

  extend Enumerize
  enumerize :kind, :in => [:design, :content, :copyright, :management, :develop, :not_planned_develop, :sysop, :support, :meeting], :default => :develop

  validates_presence_of :title

  scope :active, ->{ where(:active => true) }
  scope :today,  ->{ where('timers.start_at >= ? AND timers.end_at <= ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }

  def by_day
    start_at.to_date
  end

  def spend_time
    if active?
      @spend_time = amount.to_i + Time.zone.now.to_i - start_at.to_time.to_i
    else
      @spend_time = amount.to_i
    end
  end

  def manual_timer(date, time)
    regex = time.match(/(?<hours>\d+(h|р))?(?<minutes>(?<=h)?\d+(m|ь))?(?<seconds>(?<=m)?\d+(s|ы))?/)

    hours   = regex[1].to_i
    minutes = regex[2].to_i
    seconds = regex[3].to_i

    parsed_time = hours * 60 * 60 + minutes * 60 + seconds

    self.update_attributes!(:active => false, :amount => parsed_time, :start_at => date, :end_at => (date.to_time + parsed_time))
  end
end
