class EventsController < ApplicationController

  respond_to :json

  def index
  end

  def new
  end

  def create
    respond_with(@event = Event.create(event_params))
    # puts "@event.present? #{@event.present?}"
    # puts "@event.errors.full_messages #{@event.errors.full_messages}"
    #
    # if @event.errors.any?
    #   respond_with(@event.errors.full_messages)
    # else
    #   respond_with(@event, location: nil)
    # end
    # puts @event.errors.full_messages
  end

  def update
  end

  private

  def event_params
    params.require(:event).permit(:date, :time_from, :time_to,
                                  :event_type_id, :comment, :id,
                                  :linked_user_id, :online, :meeting_id)
  end


end
