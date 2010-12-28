h2. Redeemable


h3. Usage

h4. Make your ActiveRecord model redeemable

class Ticket < ActiveRecord::Base
  redeemable :valid_for => 30.days, :uses => 4, :code_length => 8
end

h4. Generate the model

rails generate redeemable Ticket (with your attributes)

Generator automatically adds the attributes of the model:
code:string, uses:integer, issued_at:datetime, expires_at:datetime, created_at:datetime

