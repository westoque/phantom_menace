require 'phantom_menace'

TEST_URL = "http://localhost:4567/index.html"

describe PhantomMenace::Browser do
  before do
    @browser = PhantomMenace::Browser.new
  end

  describe "#goto" do
    it "responds with success if page opens successfully" do
      resp = @browser.goto TEST_URL
      resp["success"].should == true
    end
  end

  describe "#find_all_links" do
    it "responds with the links in the page" do
      @browser.goto TEST_URL
      resp = @browser.find_all_links
      resp.length.should_not be(0)
    end
  end

  describe "#find" do
    it "responds with the links in the page" do
      @browser.goto TEST_URL
      resp = @browser.find('a')
      resp.length.should_not be(0)
    end

    it "responds with a blank array if nothing found" do
      @browser.goto TEST_URL
      resp = @browser.find('.non-existing-class')
      resp.should be_empty
    end
  end

  describe "#render" do
    it "saves the file in the path specified" do
      pending "Still working on it"
    end
  end
end
