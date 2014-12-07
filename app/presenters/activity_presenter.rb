class ActivityPresenter < SimpleDelegator
  attr_reader :activity
  
  def initialize(activity, view)
    super(view)
    @activity = activity
  end
  
  def render_activity
    div_for activity do
      link_to(activity.user.name, activity.user) + " " + render_partial
    end
  end

  def render_activity_for_json
    strip_tags(activity.user.name + " " + render_partial)
  end
  
  def render_partial
    locals = {activity: activity, presenter: self}
    locals[activity.trackable.class.to_s.underscore.to_sym] = activity.trackable
    render partial_path, locals
  end
  
  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end
  
  def partial_paths
    [
      "activities/#{activity.trackable.class.to_s.underscore}/#{activity.action}.html.erb",
      "activities/#{activity.trackable.class.to_s.underscore}.html.erb",
      "activities/activity.html.erb"
    ]
  end
end