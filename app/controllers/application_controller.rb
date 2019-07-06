class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

def google_secret
  Google::APIClient::ClientSecrets.new(
    { "web" =>
      { "access_token" => 
@user.google_token,
        "refresh_token" => 
@user.google_refresh_token,
        "client_id" => Rails.application.secrets.google_client_id,
        "client_secret" => Rails.application.secrets.google_client_secret,
      }
    }
  )
end

def get_calendars
  # Initialize Google Calendar API
  service = Google::Apis::CalendarV3::CalendarService.new
  # Use google keys to authorize
  service.authorization = google_secret.to_authorization
  # Request for a new aceess token just incase it expired
  service.authorization.refresh!
  # Get a list of calendars
  calendar_list = service.list_calendar_lists.items
  calendar_list.each do 
calendar
    puts calendar
  end
end
end
