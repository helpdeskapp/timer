class TimerPresenter
  class Parameters
    include Singleton

    attr_accessor :from, :to

    def params
      { :from => from, :to => to }
    end
  end

  class PeriodFilter
    include Rails.application.routes.url_helpers

    attr_accessor :from, :to

    def initialize(from, to)
      @from, @to = from, to
    end

    def available
      {
        { :from => nil, :to => nil } => 'Все',
        { :from => (Time.zone.now - 1.day).to_date.to_param, :to => (Time.zone.now - 1.day).to_date.to_param } => 'Вчера',
        { :from => Time.zone.now.to_date.to_param, :to => Time.zone.now.to_date.to_param } => 'Сегодня',
        { :from => (Time.zone.now - 1.week).beginning_of_week.to_date.to_param, :to => (Time.zone.now - 1.week).end_of_week.to_date.to_param } => 'Прошлая неделя',
        { :from => Time.zone.now.beginning_of_week.to_date.to_param, :to => Time.zone.now.end_of_week.to_date.to_param } => 'Эта неделя',
        { :from => (Time.zone.now - 1.month).beginning_of_month.to_date.to_param, :to => (Time.zone.now - 1.month).end_of_month.to_date.to_param } => 'Прошлый месяц',
        { :from => Time.zone.now.beginning_of_month.to_date.to_param, :to => Time.zone.now.end_of_month.to_date.to_param } => 'Этот месяц'
      }
    end

    def selected
      available.keys.include?({ :from => from, :to => to }) ? { :from => from, :to => to } : available.keys.first
    end

    def links
      available.map do |value, title|
        Hashie::Mash.new(
          :title => title,
          :klass => (value == selected)? 'selected' : '',
          :path => timers_path(Parameters.instance.params.merge(:from => value[:from], :to => value[:to])),
        )
      end
    end
  end

  attr_accessor :from, :to
  attr_reader :from, :to, :current_user, :period_filter

  def initialize(args)
    @from         ||= args[:from]
    @to           ||= args[:to]

    @current_user ||= args[:current_user]

    @page         = args[:page]
    @per_page     = args[:per_page]

    store_parameters
    initialize_filters
  end

  def collection
    current_user.timers.by_period(@from, @to)
  end

  private

  def store_parameters
    %w(from to).each { |p| Parameters.instance.send "#{p}=", send(p) }
  end

  def initialize_filters
    @period_filter = PeriodFilter.new(@from, @to)
  end
end
