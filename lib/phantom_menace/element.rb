module PhantomMenace
  class Element
    attr_reader :attributes
    attr_reader :position
    attr_reader :text

    def initialize(options)
      @attributes = options["attrs"]
      @position = options["position"]
      @text = options["text"]
    end
  end
end
