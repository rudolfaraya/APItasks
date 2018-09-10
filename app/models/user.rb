class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :tasks, foreign_key: :created_by
  # Validations
  validates_presence_of :name, :email, :password_digest
  validates :email, uniqueness: true

  include RolesConcern
end