require 'phantom_menace'

describe PhantomMenace::Browser do
  before do
    @browser = PhantomMenace::Browser.new
  end

  describe "#goto" do
    it "responds with success if page opens successfully" do
      resp = @browser.goto "http://google.com"
      resp["success"].should == true
    end
  end

  describe "#find_all_links" do
    it "responds with the links in the page" do
      @browser.goto "http://google.com"
      resp = @browser.find_all_links
      resp.length.should_not be(0)
    end
  end
end
