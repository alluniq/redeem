require 'rails/generators'

class RedeemableGenerator < Rails::Generators::Base #:nodoc:
  include Rails::Generators::Migration
  
  argument :class_name, :type => :string, :default => "User"
  
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end
  
  def initialize(runtime_args, *runtime_options)
    super
    @attributes = runtime_args.values_at(1..runtime_args.length-1)
    @class_name = runtime_args[0] if runtime_args.length > 0
  end
  
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
  
  def copy_files
    template 'model_template.rb', "app/models/#{@class_name.downcase}.rb"
    migration_template 'migration.rb', "db/migrate/create_#{@class_name.pluralize.downcase}.rb"
  end
end
