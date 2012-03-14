class WorkingDayCalendar
  def initialize
    @non_working_rules = []
  end

  def is_non_working_day day
    @non_working_rules.any? { |rule|
      rule.is_non_working_day day
    }
  end

  def add_non_working_day_rule rule
    @non_working_rules << rule
  end
end

class NonWorkingDayOfMonth
  def initialize day
    @day = day
  end

  def is_non_working_day day
    @day.day.eql?(day.day) and @day.month.eql?(day.month)
  end
end

class NonWorkingDayOfWeek
  def initialize day
    @day = day
  end

  def is_non_working_day day
    day.send "#{@day}?"
  end
end
