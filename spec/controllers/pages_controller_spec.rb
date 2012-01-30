require 'spec_helper'

describe PagesController do
  render_views
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                        :content => "Gender Detector | Home")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content =>
                          "Gender Detector | About")
    end
  end
  
  describe "GET 'result'" do
    it "should be successful" do
      get 'result'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'result'
      response.should have_selector("title",
                        :content =>
                          "Gender Detector | Result")
    end
  end

end
