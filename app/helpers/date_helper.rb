module DateHelper
  DATE_FORMAT = "%Y-%m-%d"

  private

  def to_date(date_string)
    Date.strptime(date_string, DATE_FORMAT) if date_string
  end

  def from_date(date)
    date.strftime(DATE_FORMAT)
  end
end
