class Translation < ApplicationRecord
  belongs_to :user
  validates :input, presence: true
end
