class HomeController < ApplicationController
  def show
    @sites = Site.all
    @users = User.all.order("score DESC")
    @activities_per_day = Activity.order("created_at desc")
      .group_by { |activity| activity.created_at.to_date }
  end
end
