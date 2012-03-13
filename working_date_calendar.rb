class WorkingDayCalendar
  def initialize
    @non_working = []
  end

  def is_non_working_date day
    return false if @non_working.nil?
    @non_working.any? { |non_working|
      (is_non_working_day_of_month non_working, day) or
        (is_non_working_day_of_week non_working, day)
    }
  end

  def is_non_working_day_of_month non_working, day
    return false if !(non_working.respond_to? :day or non_working.respond_to? :month)
    non_working.day.eql?(day.day) and non_working.month.eql?(day.month)
  end

  def is_non_working_day_of_week non_working, day
    return false if !(day.respond_to? "#{non_working}?".to_sym)
    day.send "#{non_working}?"
  end

  def add_non_working_day day
    @non_working << day
  end
end
