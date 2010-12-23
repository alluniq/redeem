class <%= @class_name %> < ActiveRecord::Base
  redeemable :valid_for => 30.days, :code_length => 8, :uses_by_default => 1 
end

