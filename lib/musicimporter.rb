require 'pry'
class MusicImporter 

    attr_accessor :path

    @@files = []

    def initialize(file_path = "./db/mp3s")
        @path =  file_path
    end


    def self.all 
        @@files
    end

    def files
        Dir.each_child(@path) do |file|
            if file.include?(".mp3")
                @@files << file 
            end
        end
        @@files
    end 

    def import
        @@files.each {|file| Song.create_from_filename(file)}
    end

end 