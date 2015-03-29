class Timer < ActiveRecord::Base
  attr_accessor :time, :date

  belongs_to :user

  extend Enumerize
  enumerize :kind, :in => [:design, :content, :copyright, :management, :develop, :not_planned_develop, :sysop, :support, :meeting], :default => :develop

  validates_presence_of :title

  scope :active, ->{ where(:active => true) }
  scope :today,  ->{ where('timers.start_at >= ? AND timers.end_at <= ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }
  scope :by_title_and_kind, -> (title, kind) { where('timers.title = ? AND timers.kind = ?', title, kind) }
  scope :by_period, ->(from, to) { where('timers.start_at >= ? AND timers.end_at <= ?', Date.parse(from).beginning_of_day, Date.parse(to).end_of_day) if from && to }

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

  def start!
    if self.start_at >= Time.zone.now.beginning_of_day
      self.update_attributes!(:active => true, :start_at => Time.zone.now)
    elsif Timer.where(:title => self.title, :kind => self.kind, :user_id => self.user_id).today.any?
      timer = Timer.where(:title => self.title, :kind => self.kind).today.first
      timer.update_attributes!(:active => true, :start_at => Time.zone.now)
    else
      Timer.create!(:title => self.title, :kind => self.kind, :start_at => Time.zone.now, :user_id => self.user_id)
    end
  end

  def stop!
    self.update_attributes!(:active => false, :amount => self.spend_time, :end_at => Time.zone.now)
  end
end
