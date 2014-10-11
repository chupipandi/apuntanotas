class User
  include Mongoid::Document
  include Mongoid::Timestamps

  MAIL_REGEXP = %r(^[a-z0-9!#$\%&'*+/=?^_`{|}~]+(?:[\.-][a-z0-9!#$\%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9][a-z0-9-]*[a-z0-9]$)i

  field :email,              type: String
  field :username,           type: String
  field :encrypted_password, type: String
  field :password_digest,    type: String

  has_secure_password

  validates :email,
            presence: true,
            format: { with: MAIL_REGEXP },
            uniqueness: true

  validates :username, presence: true, uniqueness: true

  before_save { self.email = email.downcase if self.email.present? }
end
