class Format < ApplicationRecord
  scope :online, ->{where(online: true).order(:name)}
end
