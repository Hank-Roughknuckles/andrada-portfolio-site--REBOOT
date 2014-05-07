class VideoWork < Work
  belongs_to :folder, class_name: "VideoCollection"
end
