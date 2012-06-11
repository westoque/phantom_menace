require "net/http"
require "uri"
require "json"

module PhantomMenace
  # PhantomMenace::Browser
  #
  # Creates a Browser that you can interact with. Exposes methods like
  # how you would find a real browser.
  #
  # == Example
  #
  #   browser = PhantomMenace::Browser.new
  #   browser.goto "http://facebook.com"
  #
  # Look at the API for more methods.
  class Browser
    # Navigates to the specified URL.
    def goto(url)
      options = {
        command: "goto",
        data: { url: url }
      }
      post(options)
    end

    def find_all_links
      options = {
        command: "find",
        data: { selector: "a" }
      }
      post(options)["ret"].map do |node|
        PhantomMenace::Element.new(node)
      end
    end

    # Uses jQuery's selector method. `$(sel)`
    def find(sel)
      options = {
        command: "find",
        data: { selector: sel }
      }
      post(options)["ret"].map do |node|
        PhantomMenace::Element.new(node)
      end
    end

    private

    def post(options)
      data = { payload: options.to_json }
      req = Net::HTTP.post_form(URI.parse(URL), data)
      JSON.parse(req.body)
    end
  end
end
