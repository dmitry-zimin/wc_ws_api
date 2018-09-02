module InputProcessor
  class StringStream
    def self.get_stream(input)
      StringIO.new(input)
    end
  end
end
