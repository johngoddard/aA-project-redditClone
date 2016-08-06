module ApplicationHelper
  def form_token
    "<input type='hidden'
            name='authenticity_token'
            value=#{form_authenticity_token}>".html_safe
  end

  def nice_time(timestamp)
    time = timestamp.in_time_zone('Pacific Time (US & Canada)').strftime("%I:%M")
    am_pm = timestamp.in_time_zone('Pacific Time (US & Canada)').strftime("%p")
    date = timestamp.strftime("%b %d")
    " (#{date} at #{time} #{am_pm.downcase})"
  end
end
