require 'spec_helper'

RSpec.describe TimeOffRequest, type: :model do
  context '#initialize' do
    it 'should instantiate based on given JSON' do

      employee_id = 123
      week = 23
      days = [1..3]
      time_off_request = TimeOffRequest.new time_off_request_json(employee_id, week, days)

      expect(time_off_request).to be_a_kind_of(TimeOffRequest)
      expect(time_off_request.employee_id).to eql(employee_id)
      expect(time_off_request.week).to eql(week)
      expect(time_off_request.days).to eql(days)
    end
  end
end

private

def time_off_request_json(employee_id, week, days)
  {employee_id:   employee_id,
   week: week,
   days: days}
end
