module InputProcessor
  class FileStream
    def self.get_stream(input_file)
      file_name = "./files/#{input_file}"
      StringIO.new(IO.read(file_name))
    end
  end
end
