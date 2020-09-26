class Event < ApplicationRecord
  validates :date, presence: true
  belongs_to :event_type
end
