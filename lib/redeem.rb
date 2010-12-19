module Redeem
  
  require File.dirname(__FILE__)+'/redeem/railtie.rb' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  #require File.dirname(__FILE__)+'/redeem/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def redeemable(options = {})
      unless redeemable? # don't let AR call this twice
        cattr_accessor :valid_for
        cattr_accessor :code_length
        cattr_accessor :uses
        before_create :setup_new
        self.valid_for = options[:valid_for] unless options[:valid_for].nil?
        self.uses = options[:uses] unless options[:uses].nil?
        self.code_length = (options[:code_length].nil? ? 6 : options[:code_length])
      end
      include InstanceMethods
      
      # Generates an alphanumeric code using an MD5 hash
      # * +code_length+ - number of characters to return
      def generate_code(code_length=6)
        chars = ("a".."z").to_a + ("1".."9").to_a 
        new_code = Array.new(code_length, '').collect{chars[rand(chars.size)]}.join
        Digest::MD5.hexdigest(new_code)[0..(code_length-1)].upcase
      end

      # Generates unique code based on +generate_code+ method
      def generate_unique_code
        begin
          new_code = generate_code(self.code_length)
        end until !active_code?(new_code)
        new_code
      end
      
      # Checks the database to ensure the specified code is not taken
      def active_code?(code)
        find :first, :conditions => {:code => code}
      end
    end
    
    def redeemable?
      self.included_modules.include?(InstanceMethods)
    end
  end
  
  module InstanceMethods
  
    def redeemed?
      self.issued_at
    end

    # Returns whether or not the redeemable has expired
    def expired?
      self.expires_at? and self.expires_on < Time.now
    end
    
    def redeem!
      if self.can_be_redeemed?
        self.uses -= 1
        true
      else
        false
      end
    end
    
    def can_be_redeemed?
      self.uses > 0
    end
    
  end  
end
