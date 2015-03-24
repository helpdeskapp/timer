module TimeFormatHelper
  def timestamp_to_hours(secs, options = {})

    hours = (secs / (60 * 60)).floor
    hours = '0' + hours.to_s if hours < 10

    divisor_for_minutes = secs % (60 * 60)
    minutes = (divisor_for_minutes / 60).floor
    minutes = '0' + minutes.to_s if minutes < 10

    divisor_for_seconds = divisor_for_minutes % 60
    seconds = (divisor_for_seconds).ceil
    seconds = '0' + seconds.to_s if seconds < 10

    if options[:short].present? && hours.to_i.zero?
      return "#{minutes}:#{seconds}"
    else
      return "#{hours}:#{minutes}:#{seconds}"
    end
  end
end
