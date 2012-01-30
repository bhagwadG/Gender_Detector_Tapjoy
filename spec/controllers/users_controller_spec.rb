require 'spec_helper'

describe UsersController do
  render_views
  
  #  Test for showing person profile page 
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end

 #   Test for new people
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Train")
    end
  end
  
 #   Test for creating people
  
   describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
        @attr = { :gender => "", :weight => nil, :height => nil}
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Train")
      end
          
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do
    
      before(:each) do
        @attr = { :gender => "male", :weight => 180, :height => 6  }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
            
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end    
    end
  end
  
 #  Tests for editing people
  
  describe "GET 'edit'" do    
    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit user")
    end
  end
  
  
#   Tests for update after edit action
  
  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :gender => "", :weight => nil, :height => nil }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit user")
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :gender => "male", :weight => 180, :height => 6}
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
      end
      
      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end
  
 # Test for listing all the users
  
  describe "GET 'index'" do

    describe "for all users" do
      
      before(:each) do
        @user =  Factory(:user)        
        @users = [@user]
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All users")
      end
      
      it "should have an element for each user" do
        get :index
        @users.each do |user|
          response.should have_selector("li", :content => "Person : #{user.id}")
        end
      end
    end
  end
 
 #   Testing for Destroy action
  
  describe "DELETE 'destroy'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "as a user " do
  
      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end
      
      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end
  end  
end
