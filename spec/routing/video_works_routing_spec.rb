require "spec_helper"

describe VideoWorksController do
  describe "routing" do

    it "routes to #index" do
      get("/video_works").should route_to("video_works#index")
    end

    it "routes to #new" do
      get("/video_works/new").should route_to("video_works#new")
    end

    it "routes to #show" do
      get("/video_works/1").should route_to("video_works#show", :id => "1")
    end

    it "routes to #edit" do
      get("/video_works/1/edit").should route_to("video_works#edit", :id => "1")
    end

    it "routes to #create" do
      post("/video_works").should route_to("video_works#create")
    end

    it "routes to #update" do
      put("/video_works/1").should route_to("video_works#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/video_works/1").should route_to("video_works#destroy", :id => "1")
    end

  end
end
