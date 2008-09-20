require 'test/unit'
require 'hyperdelegate'

Somewhere = Struct.new(:street, :city)
Someone   = Struct.new(:name, :place) do
  delegate :street, :city, :to => :place
end

class HyperdelegateTest < Test::Unit::TestCase
  
  def test_delegation
    david = Someone.new("David", Somewhere.new("Paulina", "Chicago"))
    assert_equal "Paulina", david.street
    assert_equal "Chicago", david.city
  end  

  def test_delegation_without_allow_nil
    Someone.class_eval { undef :street; delegate :street, :to => :place}
    david = Someone.new("David")
    assert_raise(NoMethodError) { david.street }
  end
  
  def test_delegation_with_allow_nil
    Someone.class_eval { undef :street; delegate :street, :to => :place, :allow_nil => true}
    david = Someone.new("David")
    assert_nil david.street
  end
  
  def test_delegation_with_target
    Someone.class_eval { delegate :town, :to => :place, :target => :city }
    david = Someone.new("David", Somewhere.new("Paulina", "Chicago"))
    assert_equal "Chicago", david.town
  end
  
end
