class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected
    def json_request?
      request.format.json?
    end

  private
    def track_activity(trackable, action = params[:action])
      current_user.activities.create! action: action, trackable: trackable
    end
end
