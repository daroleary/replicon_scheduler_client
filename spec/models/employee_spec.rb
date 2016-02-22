require 'spec_helper'

RSpec.describe Employee, type: :model do
  context '#initialize' do
    it 'should instantiate employee based on given JSON' do
      employee = Employee.new employee_json(123, 'some.name')

      expect(employee).to be_a_kind_of(Employee)
      expect(employee.id).to eql(123)
      expect(employee.name).to eql('some.name')
    end
  end
end

private

def employee_json(id, name)
  {id:   id,
   name: name}
end
