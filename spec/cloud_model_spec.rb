require File.join(File.dirname(__FILE__), %w[spec_helper])

describe "CoolBreeze::Model" do
  before do
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
end

# EOF
