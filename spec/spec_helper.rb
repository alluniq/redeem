require "rspec"
require 'sqlite3'
require 'active_record'

SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)
require "redeem"

ActiveRecord::Base.send :include, Redeem

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "spec.db"
)

class Coupon < ActiveRecord::Base
  redeemable :valid_for => 30.days, :code_length => 8, :default_number_of_uses => 1
end

if Coupon.table_exists?
  ActiveRecord::Base.connection.drop_table(:coupons)
end

if !Coupon.table_exists?
  ActiveRecord::Base.connection.create_table(:coupons) do |t|
    t.column :id, :integer
    t.column :name, :string
    t.column :expires_at, :datetime
    t.column :issued_at, :datetime
    t.column :uses, :integer
    t.column :created_at, :datetime
    t.column :updated_at, :datetime
    t.column :code, :string
    t.column :description, :text
    t.column :note_after, :text
  end
end

