require 'test/unit'
require './working_date_calendar'

module ConstantDates
  def ConstantDates.some_sunday; Time.new 2012, 03, 11; end
  def ConstantDates.some_monday; Time.new 2012, 03, 12; end
  def ConstantDates.january_first; Time.new 2012, 01, 01; end
end

class WorkingDayCalendarTest < Test::Unit::TestCase
  def setup
    @calendar = WorkingDayCalendar.new
    @some_saturday = Time.new 2012, 03, 10
    @some_tuesday = Time.new 2012, 03, 13
  end

  def test_non_working_day_of_month_rule
    @calendar.add_non_working_day_rule(
      NonWorkingDayOfMonth.new Time.new(Time.now.year, 1, 1)
    )
    assert @calendar.is_non_working_day(ConstantDates::january_first)
    assert !@calendar.is_non_working_day(ConstantDates::some_monday)
  end

  def test_non_working_day_of_week_rule
    @calendar.add_non_working_day_rule(NonWorkingDayOfWeek.new :sunday)
    assert @calendar.is_non_working_day(ConstantDates::some_sunday)
    assert !@calendar.is_non_working_day(ConstantDates::some_monday)
  end
end

class NonWorkingDayOfMonthTest < Test::Unit::TestCase
  def test_a_non_working_day_of_month_should_respond_that_the_same_day_is_non_working
    assert NonWorkingDayOfMonth.new(
      ConstantDates::january_first
    ).is_non_working_day(ConstantDates::january_first)
  end

  def test_a_non_working_day_of_month_should_respond_that_other_day_is_working
    assert !NonWorkingDayOfMonth.new(
      ConstantDates::january_first
    ).is_non_working_day(ConstantDates::some_sunday)
  end
end

class NonWorkingDayOfWeekTest < Test::Unit::TestCase
  def test_a_non_working_day_of_week_should_respond_that_the_same_day_is_non_working
    assert NonWorkingDayOfWeek.new(
      :sunday
    ).is_non_working_day(ConstantDates::some_sunday)
  end

  def test_a_non_working_day_of_week_should_respond_that_other_day_is_working
    assert !NonWorkingDayOfWeek.new(
      :sunday
    ).is_non_working_day(ConstantDates::some_monday)
  end
end
