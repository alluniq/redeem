module Redeem
  
  require File.dirname(__FILE__)+'/redeem/railtie.rb' if defined?(Rails)
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def redeemable(options = {})
      include InstanceMethods
    end
    
  end
  
  module InstanceMethods
    
    def redeem!
      puts "OK"
    end
    
    def can_be_redeemed?
      puts "Yes"
    end
    
  end  
end
