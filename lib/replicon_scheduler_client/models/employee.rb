class Employee
  attr_reader :id, :name

  def initialize(options = {})
    @id   = options[:id]
    @name = options[:name]
  end

  def ==(another_employee)
    self.id == another_employee.id
    self.name == another_employee.name
  end
end
