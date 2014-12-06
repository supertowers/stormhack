class HomeController < ApplicationController
  def show
    user_id = session[:user_id]
    if user_id
      @user = User.find(user_id)
    else
      @user = nil
    end
  end
end
