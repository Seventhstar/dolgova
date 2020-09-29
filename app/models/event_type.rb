class EventType < ApplicationRecord
  belongs_to :state_color, optional: true
end
