module Redeem
  
  require 'redeem'
  require 'rails'
  
  class Railtie < Rails::Railtie
    
    initializer 'redeem.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Redeem
      end
    end
  end
end
