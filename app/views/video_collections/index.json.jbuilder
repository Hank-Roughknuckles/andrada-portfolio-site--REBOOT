json.array!(@video_collections) do |video_collection|
  json.extract! video_collection, :id
  json.url video_collection_url(video_collection, format: :json)
end
