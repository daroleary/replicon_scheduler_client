require 'spec_helper'

RSpec.describe ShiftRule, type: :model do
  context '#initialize' do
    it 'should instantiate based on given JSON' do
      rule_id = 1
      employee_id = 2
      value = 3
      shift_rule = ShiftRule.new shift_rule_json(rule_id, employee_id, value)

      expect(shift_rule).to be_a_kind_of(ShiftRule)
      expect(shift_rule.rule_id).to eql(rule_id)
      expect(shift_rule.employee_id).to eql(employee_id)
      expect(shift_rule.value).to eql(value)
    end
  end
end

private

def shift_rule_json(rule_id, employee_id, value)
  {rule_id:   rule_id,
   employee_id: employee_id,
   value: value}
end
