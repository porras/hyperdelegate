Hyperdelegate
=============

Implementation as a plugin of [this patch](http://rails.lighthouseapp.com/projects/8994/tickets/1080-patch-more-options-to-make-delegate-more-flexible#ticket-1080-1) for Rails.

[PATCH] More options to make delegate more flexible
---------------------------------------------------

Adds two options to delegate to make it more flexible and support two frequent patterns in delegation.

You can specify a target if you don't want your method to have the same name:

	class Foo < ActiveRecord::Base
	  belongs_to :greeter
	  delegate :hi, :to => :greeter, :target => :hello
	end
	
	Foo.new.hi # returns Foo.new.greeter.hello

If the object in which you delegate can be nil, you may want to use the :allow_nil option. In that case, it returns nil instead of raising a NoMethodError exception:


	class Foo
	  def initialize(bar = nil)
	    @bar = bar
	  end
	  delegate :zoo, :to => :bar
	end

	Foo.new.zoo   # raises NoMethodError exception (you called nil.zoo)

	class Foo
	  def initialize(bar = nil)
	    @bar = bar
	  end
	  delegate :zoo, :to => :bar, :allow_nil => true
	end

	Foo.new.zoo   # returns nil

Copyright (c) 2008 [Sergio Gil](sgilperez@gmail.com), released under the MIT license
