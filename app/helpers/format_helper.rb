Perft::App.helpers do
  def format_date(datetime)
    datetime ? datetime.strftime("%F") : ""
  end

  def format_time(datetime)
    datetime ? datetime.strftime("%r") : ""
  end
end
