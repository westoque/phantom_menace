require "phantom_menace"

browser = PhantomMenace::Browser.new
browser.goto("http://bigbadgoose.com")
links = browser.find_all_links
links.map do |link|
  p link.attributes["href"]
end
