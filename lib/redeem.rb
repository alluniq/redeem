module Redeem
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
      
    end
    
    def can_be_redeemed?
      
    end
    
  end  
end