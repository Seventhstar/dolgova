class Meeting < ApplicationRecord
  belongs_to :format
  belongs_to :duration
end
