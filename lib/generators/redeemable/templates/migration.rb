class <%= "Create#{@class_name.pluralize}" %> < ActiveRecord::Migration
  def self.up
    create_table :<%= @file_name.pluralize %> do |t|

      t.column :code, :string
      t.column :uses, :integer
      t.column :issued_at, :datetime
      t.column :expires_at, :datetime
      t.column :created_at, :datetime
    <%- @attributes.each do |attribute| %>
      <%- attribute = attribute.split(":") %>
      <%= "t.column :#{attribute[0]}, :#{attribute[1]}" %>
    <%- end %>
      t.timestamps
    end
  end

  def self.down
    drop_table :<%= @file_name.pluralize %>
  end
end
