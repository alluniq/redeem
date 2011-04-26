class <%= @class_name %> < ActiveRecord::Base
  redeemable :valid_for => 30.days, :code_length => 8, :default_number_of_uses => 1 
end

