class UsersController < ApplicationController
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user  = User.find(params[:id])
    @title = @user.id
  end
  
  def new
    @user  = User.new
    @title = "Train"
  end
  
  def create
    @user = User.new(params[:user])
    simp_ = User.new(params[:user])
    if @user.gender.blank?
       require './bayes'
       b_obj= Bayes.new()
        gende = b_obj.predict(@user.height, @user.weight)
#        render :text => "The object is #{gende}"
       logger.info "GENDER: #{gende}"
       simp_.gender = b_obj.predict(@user.height, @user.weight)
       predict_(simp_)
    else
      if @user.save
        redirect_to @user
      else
        @title = "Train"
        render 'new'
      end
    end
  end
  
  def predict_(_user)
    @user = _user
    render 'predicted'
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end
end
