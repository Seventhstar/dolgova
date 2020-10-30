class AjaxController < ApplicationController
  respond_to :js, :json
  skip_before_action :verify_authenticity_token, only: [:write_in]

  def write_in
    data = params.require(:data)
    user = User.find_by_email(data[:email])
    if user.nil?
      user = User.find_by_phone(data[:phone])
    end

    puts "user #{user.to_json}"

    if user.present?
      event = Event.find_by(date: data[:event][:date], time_from: data[:event][:time])
      if event.present?
        event.update!({linked_user_id: user.id,
                       comment: data[:event][:comment],
                                 event_type_id: 4})
        render json: {head: :ok}
      end
    end

    if user.nil? || event.nil?
      render json: {error: "Что-то пошло не так", status: 400}, status: 400
    end

  end
end
