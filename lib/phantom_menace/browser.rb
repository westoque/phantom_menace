require "net/http"
require "uri"
require "json"

module PhantomMenace
  class Browser
    def goto(url)
      options = {
        command: "goto",
        data: url
      }
      post(options)
    end

    def find_all_links
      options = {
        command: "find"
      }
      post(options)["ret"].map do |node|
        PhantomMenace::Element.new(node)
      end
    end

    private

    def post(options)
      req = Net::HTTP.post_form(URI.parse(URL), options)
      JSON.parse(req.body)
    end
  end
end
