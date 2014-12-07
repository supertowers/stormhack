json.array!(@activities) do |activity|
  json.activity ActivityPresenter.new(activity, self).render_activity_for_json
  json.url url_for(activity.trackable.site)
end