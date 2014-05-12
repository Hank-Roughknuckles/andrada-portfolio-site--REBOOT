require 'spec_helper'

describe "VideoCollections" do

  subject{ page }

  FactoryGirl.create(:landing_page_photo)

  let!(:user) { FactoryGirl.create(:user) }
  let!(:parent_collection) do 
    FactoryGirl.create(:video_collection, name: "Parent Collection") 
  end
  let!(:child_collection) do 
    FactoryGirl.create(:video_collection, parent: parent_collection, 
                                          name: "Child Collection") 
  end
  let!(:top_level_work) do 
    FactoryGirl.create(:video_work, folder_id: nil)
  end
  let!(:work_in_parent_collection) do 
    FactoryGirl.create(:video_work, folder_id: parent_collection.id) 
  end
  let!(:work_in_child_collection) do 
    FactoryGirl.create(:video_work, folder_id: child_collection.id,
                                    tile_image_link: "http://i.kinja-img.com/gawker-media/image/upload/s--5JnGzvw3--/c_fit,fl_progressive,q_80,w_636/714259831889653140.jpg") 
  end

  before do
    visit root_path 
    click_link "Video"
  end

  ########################################################################
  #
  # The Index page
  #
  ########################################################################
  describe "The Index Page" do
    it { should have_title "Video" } 
    it { should have_content "Video" }

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # "Create" buttons
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    describe "when signed out" do
      before do
        logout user
        visit root_path
        click_link "Video"
      end 

      it "shouldn't have the option to make new works or collections" do  
        #new collection
        expect(page).not_to have_xpath( %Q(
          //a[@href="#{new_video_collection_path}"]
          )
        )
        #new work
        expect(page).not_to have_xpath( %Q(
          //a[@href="#{new_video_work_path}"]
          )
        )
      end
      it "shouldn't have the option to destroy works or collections" do
        expect(page).not_to have_link( "Delete" )
      end
    end

    describe "when signed in" do
      before do
        login_as user
        visit root_path
        click_link "Video"
      end 

      it "should have the option to make new works or collections" do  
        expect(page).to have_xpath( %Q(
          //a[@href="#{new_video_collection_path}"]
          )
        )
        expect(page).to have_xpath( %Q(
          //a[@href="#{new_video_work_path}"]
          )
        )
      end
    end

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # Top level works/collections
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    describe "the top level works and collections" do
      describe "the collection" do
        let(:parent_image_xpath) do
          "//img[@src=\"#{parent_collection.tile_image_link}\"]"
        end


        it do 
          should have_link(parent_collection.name, 
            href: video_collection_path(parent_collection))
        end

        it { should have_xpath(parent_image_xpath) }

        it { should have_selector("#collection-#{parent_collection.id}") }
      end

      describe "the works" do
        let(:work_image_xpath) do
          "//img[@src=\"#{top_level_work.tile_image_link}\"]" 
        end

        it { should have_xpath      work_image_xpath }
        it { should have_selector   "#work-#{top_level_work.id}" }
        
        describe "the works inside of collections" do
          it { should_not have_selector "#work-#{work_in_parent_collection.id}" }
          it { should_not have_selector "#work-#{work_in_child_collection.id}" }
        end
      end
    end

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # 1-deep works/collections
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    describe "the inside of the parent-collection" do
      before { click_link parent_collection.name }

      it { should have_content parent_collection.name }

      describe "the child collection" do
        let(:child_image_xpath) do
          "//img[@src=\"#{child_collection.tile_image_link}\"]"
        end

        it { should have_xpath(child_image_xpath) }

        it do 
          should have_link(child_collection.name, 
            href: video_collection_path(child_collection))
        end

        it { should have_selector("#collection-#{child_collection.id}") }

        describe "the breadcrumbs" do
          it "should have breadcrumbs" do
            expect(page).to have_xpath(%Q(
              //div[@class='breadcrumbs']
                //a[@href=\"#{root_path}\"]
              )
            )
            expect(page).to have_xpath(%Q(
              //div[@class='breadcrumbs']
                //a[@href=\"#{video_collections_path}\"]
              )
            )
          end
        end

        #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        # 2-deep works/collections
        #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        describe "inside the child collection" do
          before { click_link child_collection.name }

          describe "the works inside the child collection" do
            let(:work_image_xpath) do
              "//img[@src=\"#{work_in_child_collection.tile_image_link}\"]" 
            end

            it { should have_xpath      work_image_xpath }
            it { should have_selector   "#work-#{work_in_child_collection.id}" }

            describe "the works inside of the other collections" do
              it { should_not have_selector "#work-#{work_in_parent_collection.id}" }
              it { should_not have_selector "#work-#{top_level_work.id}" }
            end
          end

          describe "the breadcrumbs" do
            it "should have breadcrumbs" do
              expect(page).to have_xpath(%Q(
                //div[@class='breadcrumbs']
                  //a[@href="#{root_path}"]
                )
              )
              expect(page).to have_xpath(%Q(
                //div[@class='breadcrumbs']
                  //a[@href="#{video_collections_path}"]
                )
              )

              expect(page).to have_xpath(%Q(
                //div[@class='breadcrumbs']
                  //a[@href=
                    "#{video_collection_path(child_collection.parent)}"]
                )
              )
            end
          end
        end
      end

      describe "the works inside the parent collection" do
        let(:work_image_xpath) do
          "//img[@src=\"#{work_in_parent_collection.tile_image_link}\"]" 
        end

        it { should have_xpath      work_image_xpath }
        it { should have_selector   "#work-#{work_in_parent_collection.id}" }
        
        describe "the works inside of the other collections" do
          it { should_not have_selector "#work-#{work_in_child_collection.id}" }
          it { should_not have_selector "#work-#{top_level_work.id}" }
        end
      end
    end
  end

  ########################################################################
  #
  # The Edit View
  #
  ########################################################################
  describe "The edit page" do
    describe "when not logged in" do
      before do
        logout user
        visit edit_video_collection_path(parent_collection)
      end
      it { should have_content "Please log in" }
    end

    describe "when logged in" do
      before do
        login_as user
        visit edit_video_collection_path(parent_collection)
      end

      it { should have_field "Name" }
      it { should have_field "Parent" }
      it { should have_field "image" }
      it { should have_content "Reload" }
      it { should have_xpath(
            %Q(//img[ @src="#{parent_collection.tile_image_link}"])
      )}
      it { should_not have_select('video_collection_parent_id', 
                                  options: [child_collection.name]) }

      #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      # Editing with valid information
      #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      describe "editing a collection" do
        describe "with valid information" do
          let!(:new_parent)     { "No Parent" }
          let!(:new_name)       { "Altered Name" }
          let!(:new_image)      { "http://www.asfim.ma/upload/CaRtOuChE_3/Image_3_160.jpg" }

          before do
            visit edit_video_collection_path(child_collection)
            select(new_parent,        from: "video_collection_parent_id")
            fill_in "Name",           with:   new_name
            fill_in "image", with:   new_image
            click_button "Save"
          end
          
          specify { expect(child_collection.reload.name).to eq new_name}
          specify { expect(child_collection.reload.parent_id).to eq nil }
          specify { expect(child_collection.reload.tile_image_link).to eq new_image }
          it { should have_xpath "//img[@src=\"#{new_image}\"]" }
        end
      end
      
      #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      # Moving a collection to be inside another
      #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      describe "moving a collection" do
        before do
          visit edit_video_collection_path(child_collection)
          select("No Parent",       from: "video_collection_parent_id")
          click_button "Save"
          visit video_collections_path
          click_link "collection-#{child_collection.id}"
        end

        it "should still have all its content" do
          expect(page).to have_xpath(
            "//img[@src=\"#{work_in_child_collection.tile_image_link}\"]"
          )
        end
      end

    end
  end

  ########################################################################
  #
  # The New View
  #
  ########################################################################
  describe "The new view" do
    describe "when not logged in" do
      before do
        logout user
        visit new_video_collection_path parent_collection
      end

      it { should have_content "Please log in" }
    end

    describe "when logged in" do
      before do
        login_as user
        visit new_video_collection_path
      end

      describe "page contents" do
        it { should have_field "Name" }
        it { should have_field "Parent" }
        it { should have_select('video_collection_parent_id', 
                                options: ["No Parent", 
                                          parent_collection.name, 
                                          child_collection.name]) 
        }
        it { should have_field "image" }
        it { should have_content "Reload" }
      end

      describe "the creation process" do
        describe "with invalid information" do
          before do
            fill_in "Name", with: "a"*51
            fill_in "image", with: "www.youtube.com/watch?v=WDKldgwuzjg"
            click_button "Save"
          end

          it { should have_selector "#error_explanation", 
               text: "Name is too long" }
          it { should have_selector "#error_explanation", 
               text: "Tile image link is invalid" }
        end

        #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        # Creating with valid information
        #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        describe "with valid information" do
          let!(:new_name) { "a collection with no parent" }
          let!(:new_image) { "http://i.imgur.com/kWIYqOg.png" }
          before do
            fill_in "Name", with: new_name
            fill_in "image", with: new_image
            click_button "Save"
          end
          
          it { should have_content "New Video Entry" }
          it { should have_content new_name }
        end
      end
    end
  end
end
