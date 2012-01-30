# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  gender     :string(255)
#  weight     :integer
#  height     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
 
  before(:each) do
    @attr = { :gender => "male", :weight => 190, :height => 6 }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require gender for training" do
    no_gender_user = User.new(@attr.merge(:gender => ""))
    no_gender_user.should_not be_valid
  end
  
  it "should require a weight value for training" do
    no_weight_user = User.new(@attr.merge(:weight => nil))
    no_weight_user.should_not be_valid
  end
  
  it "should require a height value for training" do
    no_height_user = User.new(@attr.merge(:height => nil))
    no_height_user.should_not be_valid
  end
end
