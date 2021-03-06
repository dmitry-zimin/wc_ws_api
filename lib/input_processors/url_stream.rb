require 'open-uri'

module InputProcessor
  class UrlStream
    def self.get_stream(input_url)
      download = open(input_url)
      file_name = "./files/tmp/#{download.base_uri.to_s.split('/')[-1]}"
      IO.copy_stream(download, file_name)
      StringIO.new(IO.read(file_name))
    end
  end
end
