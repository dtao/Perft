Perft::App.helpers do
  def format_day(datetime)
    datetime ? datetime.strftime("%A") : ""
  end

  def format_date(datetime)
    datetime ? datetime.strftime("%F") : ""
  end

  def format_time(datetime)
    datetime ? datetime.strftime("%r") : ""
  end

  def format_decimal(decimal)
    decimal ? "%0.3f" % decimal : ""
  end
end
