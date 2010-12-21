require "rspec"
require "redeem"

class Coupon < ActiveRecord::Base
  redeemable
end
