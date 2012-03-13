require 'test/unit'
require './working_date_calendar'

class TestXXX < Test::Unit::TestCase
  def setup
    @calendar = WorkingDayCalendar.new
    @some_sunday = Time.new 2012, 03, 11
    @some_monday = Time.new 2012, 03, 12
    @some_saturday = Time.new 2012, 03, 10
    @some_tuesday = Time.new 2012, 03, 13
  end

  def test_when_calendar_has_a_non_working_day_of_week_return_non_working_for_that_day_of_week
    @calendar.add_non_working_day(:sunday)
    assert @calendar.is_non_working_date(@some_sunday)
  end

  def test_when_calendar_has_a_non_working_day_of_week_return_working_for_other_day_of_week
    @calendar.add_non_working_day(:sunday)
    assert !@calendar.is_non_working_date(@some_monday)
  end

  def test_3
    @calendar.add_non_working_day(:saturday)
    @calendar.add_non_working_day(:sunday)
    assert @calendar.is_non_working_date(@some_sunday)
    assert @calendar.is_non_working_date(@some_saturday)
    assert !@calendar.is_non_working_date(@some_monday)
  end

  def test_6
    @calendar.add_non_working_day(Time.new Time.now.year, 1, 1)
    @calendar.add_non_working_day(Time.new Time.now.year, 2, 3)
    assert @calendar.is_non_working_date(Time.new 2012, 1, 1)
    assert @calendar.is_non_working_date(Time.new 2012, 2, 3)
  end

  def test_7
    @calendar.add_non_working_day(Time.new Time.now.year, 1, 1)
    @calendar.add_non_working_day(Time.new Time.now.year, 2, 3)
    assert !@calendar.is_non_working_date(Time.new 2012, 4, 1)
  end
end
