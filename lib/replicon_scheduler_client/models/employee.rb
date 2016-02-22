class Employee
  # include ActiveModel::Validations
  # include ActiveModel::Conversion
  # extend ActiveModel::Naming

  attr_accessor :id, :name

  def initialize(options = {})
    @id   = options[:id]
    @name = options[:name]
  end
end
