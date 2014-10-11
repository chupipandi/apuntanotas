class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  MAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  field :email,              type: String
  field :username,           type: String
  field :encrypted_password, type: String
  field :password_digest,    type: String

  has_secure_password

  validates :email,
            presence:   true,
            format:     { with: MAIL_REGEXP },
            uniqueness: true

  validates :username, presence: true, uniqueness: true

  before_save { self.email = email.downcase if self.email.present? }
end
