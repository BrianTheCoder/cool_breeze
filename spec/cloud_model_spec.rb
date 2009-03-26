require File.join(File.dirname(__FILE__), %w[spec_helper])

describe "CoolBreeze::Model" do
  before do
    CoolBreeze::Connections.setup(:redis, Redis.new)
    CoolBreeze::Connections.setup(:tokyo, Rufus::Tokyo::TyrantTable.new('localhost', 45000))
    @data = {
      "profile_image_url" => "http://s3.amazonaws.com/twitter_production/profile_images/74591615/01-30-09_2327_normal.jpg", 
      "created_at" => "Sun, 22 Mar 2009 00:13:11 +0000",
      "from_user" => "pbrendel",
      "text" => "first time i've noticed not having digital antenna. don't get austin cbs anymore, so no horns. (internet tv to the rescue)",
      "to_user_id" => nil,
      "id" => 1368224751,
      "from_user_id" => 4205104,
      "iso_language_code" => "en",
      "source" => "&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;"
    }
  end
  it 'should take an optional paramter to new and set the data' do
    m = Message.new(@data)
    m.data.should == @data.each{|k,v| @data[k] = v.to_s}
  end
  
  describe 'class_index' do
    it 'should add a class level method with the same name as the symbol' do
      Message.should respond_to(:count)
    end
    
    it 'should fetch the value at the appropriate key' do
      Message.count.should == Message.adapter(:redis)['message:count']
    end
  end
  
  describe 'instance_index' do
    it 'should add a instance level method with the same name as the symbol' do
      m = Message.new
      m.should respond_to(:tags)
    end
  end
  
  describe 'property method' do
    before do
      @u = User.new
    end
    
    describe 'should add a setter' do
      it 'adds an instance method' do
        @u.should respond_to(:"email=")
      end
      
      it 'should update the data when set' do
        @u.email = "test@gmail.com"
        @u.data['email'].should == "test@gmail.com"
      end
    end
    
    describe 'should add a getter' do
      it 'adds an instance method' do
        @u.should respond_to(:email)
      end
      
      it 'should update the data when set' do
        @u.email.should be_nil
        @u.data['email'] = "test@gmail.com"
        @u.email.should == "test@gmail.com"
      end
    end
    
    describe 'it should add a question method' do
      it 'adds an instance method' do
        @u.should respond_to(:"email?")
      end
    end
    
    describe 'validations' do
      %w(
        validates_acceptance_of
        validates_confirmation_of
        validates_each
        validates_format_of
        validates_length_of
        validates_numericality_of
        validates_presence_of
        validates_true_for
      ).each do |meth|
        it "has the validation #{meth}" do
          User.should respond_to(meth.to_sym)
        end
      end
    end
  end
end

# EOF
