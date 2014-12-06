json.array!(@vulnerabilities) do |vulnerability|
  json.extract! vulnerability, :id, :user_id, :title, :description, :approved
  json.url vulnerability_url(vulnerability, format: :json)
end
