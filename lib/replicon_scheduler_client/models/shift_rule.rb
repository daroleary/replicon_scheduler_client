class ShiftRule
  attr_reader :rule_id, :employee_id, :value

  def initialize(options={})
    @rule_id     = options[:rule_id]
    @employee_id = options[:employee_id]
    @value       = options[:value]
  end
end