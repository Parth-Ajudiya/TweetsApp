class User < ApplicationRecord

    before_save { email.downcase! }
    validates :name, presence: true,
                        length: {maximum: 51}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                        length: {maximum: 251},
                        format: {with: VALID_EMAIL_REGEX},
                        uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6}
end
