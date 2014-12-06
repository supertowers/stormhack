json.array!(@participations) do |participation|
  json.extract! participation, :id, :type, :user_id, :site_id
  json.url participation_url(participation, format: :json)
end
