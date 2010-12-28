Redeemable
==========

This gem provides redeem capability for ActiveRecord models, it can be used for coupons, tickets, etc.

Usage
-----

### Add redeem capability to your ActiveRecord model

    class Ticket < ActiveRecord::Base

        redeemable :valid_for => 30.days, :default_number_of_uses => 4, :code_length => 8

    end

Make sure that the model has attributes:

code:string, uses:integer, issued_at:datetime, expires_at:datetime, created_at:datetime 


### Generate the model

    rails generate redeemable ClassName attributes

Generator automatically adds the attributes of the model:

code:string, uses:integer, issued_at:datetime, expires_at:datetime, created_at:datetime


