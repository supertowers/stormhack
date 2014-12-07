json.array!(@sites) do |site|
  json.extract! site, :id, :url, :user_id, :status, :screenshot, :public_description
  json.url site_url(site, format: :json)
end
