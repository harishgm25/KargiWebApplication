json.array!(@findconnections) do |findconnection|
  json.extract! findconnection, :id, :friend, :status
  json.url findconnection_url(findconnection, format: :json)
end
