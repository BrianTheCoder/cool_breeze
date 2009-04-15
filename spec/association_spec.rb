require File.join(File.dirname(__FILE__), %w[spec_helper])

describe "Associations" do
  before do
    @user = User.new
  end
  
  it "defines the method on a instance" do
    @user.respond_to?(:messages).should be_true
  end
  
  it "has a destroy method" do
    @user.messages.respond_to?(:destroy).should be_true
  end
  
  it "has an add method" do
    @user.messages.respond_to?(:add).should be_true  
  end
  
  it "has a remove method" do
    @user.messages.respond_to?(:remove).should be_true
  end
  
  it "has a get method" do
    @user.messages.respond_to?(:get).should be_true
  end
  
  it "responds to each" do
    @user.messages.respond_to?(:each).should be_true
  end
  
  it "responds to first" do
    @user.messages.respond_to?(:first).should be_true
  end
end