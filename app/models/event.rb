class Event < ApplicationRecord
  validates :date, presence: true
  belongs_to :event_type
  belongs_to :meeting
  belongs_to :linked_user, class_name: 'User', foreign_key: :linked_user_id

  def linked_user_name
    self.linked_user&.name
  end

  def linked_user_phone
    self.linked_user&.phone
  end

  def color
    self.event_type&.state_color&.color
  end

  def meeting_name
    self.meeting&.name
  end

  def tarif_info
    self.linked_user&.tarif&.name
  end

end
