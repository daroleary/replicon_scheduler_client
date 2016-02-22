class TimeOffRequest
  attr_reader :employee_id, :week, :days

  def initialize(options = {})
    @employee_id   = options[:employee_id]
    @week = options[:week]
    @days = options[:days]
  end
end
