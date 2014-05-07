require "spec_helper"

describe VideoCollectionsController do
  describe "routing" do

    it "routes to #index" do
      get("/video_collections").should route_to("video_collections#index")
    end

    it "routes to #new" do
      get("/video_collections/new").should route_to("video_collections#new")
    end

    it "routes to #show" do
      get("/video_collections/1").should route_to("video_collections#show", :id => "1")
    end

    it "routes to #edit" do
      get("/video_collections/1/edit").should route_to("video_collections#edit", :id => "1")
    end

    it "routes to #create" do
      post("/video_collections").should route_to("video_collections#create")
    end

    it "routes to #update" do
      put("/video_collections/1").should route_to("video_collections#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/video_collections/1").should route_to("video_collections#destroy", :id => "1")
    end

  end
end
