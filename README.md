Redeemable
==========


Usage
-----

Make your ActiveRecord model redeemable
+++++++++++++++++++++++++++++++++++++++++

class Ticket < ActiveRecord::Base
  redeemable :valid_for => 30.days, :uses => 4, :code_length => 8
end

Generate the model
_________________
rails generate redeemable Ticket (with your attributes)

Generator automatically adds the attributes of the model:
code:string, uses:integer, issued_at:datetime, expires_at:datetime, created_at:datetime

