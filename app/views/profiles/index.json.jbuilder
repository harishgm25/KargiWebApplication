json.array!(@profiles) do |profile|
  json.extract! profile, :id, :firstname, :lastname, :shopname, :address, :tanvat, :registerno, :shopestablishment, :tradelicense, :manufacturinglicense
  json.url profile_url(profile, format: :json)
end
