module ActivityHelper
  def icon_for_activity(type)
    css_class = 'icon-li fa text-secondary '
    css_class += case type
    when 'Participation' then 'fa-eye'
    when 'Vulnerability' then 'fa-bug'
    end
    content_tag(:i, '', class: css_class)
  end
end