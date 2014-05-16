FactoryGirl.define do
  factory :user do
    email     "user@example.com"
    password  "exampleexample"
  end

  factory :landing_page_photo do
    link      "http://i.imgur.com/vHA8Mke.jpg"
  end

  factory :work do |u|
    u.sequence(:header) { |n| "Header #{n}" }
    u.sequence(:description) { |n| "Description #{n}" }
    work_link         "https://www.google.com/images/srpr/logo11w.png"
    tile_image_link   "https://www.google.com/images/srpr/logo11w.png"
    u.sequence(:position)   {|n| n}

    factory :video_work, class: VideoWork do 
    end
  end

  factory :collection do |collection|

    factory :video_collection, class: VideoCollection do |u|
      u.sequence(:name) { |n| "Video Collection #{n}" }
      tile_image_link   "http://4.bp.blogspot.com/-Yv8pu23VIQk/UwqudtA4_KI/AAAAAAAAEjk/3lGSOmuFonQ/s1600/pencil-1.png"
      u.sequence(:position)   {|n| n}
      type "VideoCollection"
    end
  end

  factory :about_me_content do
    id "0"
    header "header"
    description "my_description"
    button_title "my_button_title"
  end

  factory :showreel do
    id "0"
    description "This is my description.  I hope you like it!"
    media_link "http://vimeo.com/82123812"
    media_choice "link"
    header "My Showreel"
  end

  factory :current_project do |u|
    u.sequence(:id) {|n|}
    u.sequence(:header) {|n| "Header #{n}"}
    u.sequence(:description) {|n| "This is my description #{n}."}
    u.progress 65
    u.media_choice "link"
    u.media_link "http://vimeo.com/82123812"
  end

  factory :contact do |u|
    id "0"
    email "asdf@adsf.com"
    vimeo_id "asdfasdf"
  end
end
