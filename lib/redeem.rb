module Redeem
  
  require File.dirname(__FILE__)+'/redeem/railtie.rb' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  #require File.dirname(__FILE__)+'/redeem/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  DEFAULT_LENGTH = 6
  
  module ClassMethods
    
    def redeemable(options = {})
      unless redeemable?
        cattr_accessor :valid_for
        cattr_accessor :code_length
        cattr_accessor :uses_by_default
        before_create :initialize_new
        self.valid_for = options[:valid_for] unless options[:valid_for].nil?
        self.uses_by_default = options[:uses_by_default] unless options[:uses_by_default].nil?
        self.code_length = (options[:code_length].nil? ? DEFAULT_LENGTH : options[:code_length])
      end
      include InstanceMethods
      
      def generate_code(code_length=DEFAULT_LENGTH)
        chars = ("a".."z").to_a + ("1".."9").to_a 
        new_code = Array.new(code_length, '').collect{chars[rand(chars.size)]}.join
        Digest::MD5.hexdigest(new_code)[0..(code_length-1)].upcase
      end

      def generate_unique_code
        begin
          new_code = generate_code(self.code_length)
        end until !active_code?(new_code)
        new_code
      end
      
      def active_code?(code)
        (find :first, :conditions => {:code => code}).nil? ? false : true
      end
    end
    
    def redeemable?
      self.included_modules.include?(InstanceMethods)
    end
  end
  
  module InstanceMethods
    
    def redeemed?
      self.issued_at != nil
    end

    def expired?
      self.expires_at < Time.now
    end
    
    def redeem!
      if self.can_be_redeemed?
        self.issued_at = Time.now
        self.uses -= 1
        self.save
        true
      else
        false
      end
    end
    
    def can_be_redeemed?
      self.uses > 0 && Time.now < self.expires_at
    end
    
    def initialize_new
      self.code = self.class.generate_unique_code if self.code == nil
      unless self.class.valid_for.nil?
        self.expires_at = Time.now + self.class.valid_for
      end
      unless self.class.uses_by_default.nil?
        self.uses = self.class.uses_by_default
      end
    end
    
    def after_redeem() end
  end  
end
