require 'spec_helper'

RSpec.describe RuleDefinition, type: :model do
  context '#initialize' do
    it 'should instantiate rule definition based on given JSON' do
      id = 1
      definition = 'some.definition'
      description = 'some.description'
      rule_definition = RuleDefinition.new rule_definition_json(id, definition, description)

      expect(rule_definition).to be_a_kind_of(RuleDefinition)
      expect(rule_definition.id).to eql(id)
      expect(rule_definition.value).to eql(definition)
      expect(rule_definition.description).to eql(description)
    end
  end
end

private

def rule_definition_json(id, value, description)
  {id:   id,
   value: value,
   description: description}
end
