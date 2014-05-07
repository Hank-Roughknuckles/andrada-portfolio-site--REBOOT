class VideoCollection < Collection
  has_many :video_works, foreign_key: "folder_id"
end
