class AjaxController < ApplicationController
  respond_to :js, :json
  skip_before_action :verify_authenticity_token, only: [:write_in]

  def write_in

    data = params.require(:data)
    # puts "params #{params}"
    puts "data #{data}- #{data[:event]}"

    user = User.find_by_email(data[:email])
    if user.nil?
      user = User.find_by_phone(data[:phone])
      #puts "user by phone #{user}"
    end
    #puts "user #{user}"
    if user.present?
      event = Event.find_by(date: data[:event][:date])
      puts "event #{event}"
      if event.present?
        event.update_attributes({linked_user_id: user.id,
                                 event_type_id: 4})
        # comment: data[:event][:comment]
        render json: {head: :ok}
      end

      if user.nil? || event.nil?
        render json: {error: "Что-то пошло не так", status: 400}, status: 400
      end
    end
  end
end
