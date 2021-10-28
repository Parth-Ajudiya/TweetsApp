class User < ApplicationRecord

    attr_accessor :remember_token

    before_save { email.downcase! }
    validates :name, presence: true,
                        length: {maximum: 51}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                        length: {maximum: 251},
                        format: {with: VALID_EMAIL_REGEX},
                        uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6}, allow_nil: true

    # There are two method for declare "self" method  1) "class << self" 2) self.methode_name (as it is below declaration) 
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token
    def self.new_token
        SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in sessions
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?
        (remember_token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

end
