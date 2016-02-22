require 'spec_helper'

RSpec.describe Week, type: :model do
  context '#initialize' do
    it 'should instantiate based on given JSON' do
      id = 1
      start_date = '2014/12/29'
      week = Week.new week_json(id, start_date)

      expect(week).to be_a_kind_of(Week)
      expect(week.id).to eql(id)
      expect(week.start_date).to eql(start_date.to_date)
    end
  end
end

private

def week_json(id, start_date)
  {id:   id,
   start_date: start_date}
end
