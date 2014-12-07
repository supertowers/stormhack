class HomeController < ApplicationController
  def show
    @sites = Site.all
    @users = User.all.order("score DESC")
  end
end
