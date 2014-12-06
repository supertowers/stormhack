json.array!(@sites) do |site|
  json.extract! site, :id, :url, :user_id, :status
  json.url site_url(site, format: :json)
end
