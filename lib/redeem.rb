module Redeem
  
  require '~/Praca/redeem/lib/redeem/railtie.rb' if defined?(Rails)
  
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
