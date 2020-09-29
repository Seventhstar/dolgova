class EventsController < ApplicationController
  before_action :load_event, only: [:show, :destroy, :edit, :update]
  respond_to :json

  def index
  end

  def new
  end

  def create
    respond_with(@event = Event.create(event_params), location: nil)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  private

  def event_params
    params.require(:event).permit(:date, :time_from, :time_to,
                                  :event_type_id, :comment, :id,
                                  :linked_user_id, :online, :meeting_id)
  end

  def load_event
    @event = Event.find(params[:id])
  end



end
