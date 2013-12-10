class User < ActiveRecord::Base
  validates_confirmation_of :password
  validates :name, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

end
