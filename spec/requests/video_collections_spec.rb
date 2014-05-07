require 'spec_helper'

describe "VideoCollections" do

  subject{ page }

  FactoryGirl.create(:landing_page_photo)

  let!(:parent_collection) do 
    FactoryGirl.create(:video_collection) 
  end
  let!(:child_collection) do 
    FactoryGirl.create(:video_collection, parent: parent_collection) 
  end
  let!(:top_level_work) do 
    FactoryGirl.create(:video_work, folder_id: nil)
  end
  let!(:work_in_parent_collection) do 
    FactoryGirl.create(:video_work, folder_id: parent_collection.id) 
  end
  let!(:work_in_child_collection) do 
    FactoryGirl.create(:video_work, folder_id: child_collection.id) 
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

      describe "the back button" do
        let(:back_button_xpath) do
          "//a[@href=\"#{video_collections_path}\"]"
        end
        it { should have_xpath back_button_xpath }
      end

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

          describe "the back button" do
            let(:back_button_xpath) do
              "//a[@href=\"#{video_collection_path(child_collection.parent)}\"]"
            end
            it { should have_xpath back_button_xpath }
          end

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
            describe "the breadcrumbs" do
              before { print page.html }

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

  describe "The new page" do
    describe "when not logged in" do
      #test for lack of "new project" button
    end
    describe "when logged in" do
    end
  end
end
