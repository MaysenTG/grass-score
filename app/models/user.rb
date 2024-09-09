class User < ApplicationRecord
  has_many :players
  belongs_to :account

  validates :name, presence: true
end
