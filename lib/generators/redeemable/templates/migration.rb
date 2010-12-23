class <%= "Create#{@class_name.pluralize}" %> < ActiveRecord::Migration
  def self.up
    create_table :<%= @class_name.pluralize.downcase %> do |t|

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
    drop_table :<%= @class_name.pluralize.downcase %>
  end
end
