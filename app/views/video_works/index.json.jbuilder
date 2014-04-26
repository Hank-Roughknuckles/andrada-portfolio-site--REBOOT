json.array!(@video_works) do |video_work|
  json.extract! video_work, :id
  json.url video_work_url(video_work, format: :json)
end
