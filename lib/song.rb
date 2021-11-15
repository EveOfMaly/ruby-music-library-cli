require 'pry'
class Song
    attr_accessor :name, :artist, :genre 

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist = artist if artist
        self.genre = genre if genre 
    end

    def artist=(artist)
        @artist = artist 
        artist.add_song(self)
    end

    def save 
        @@all << self 
    end

    def self.create(new_song)
        new_instance = Song.new(new_song)
        new_instance.save
        new_instance
    end

    def self.all 
        @@all
    end

    def self.destroy_all
        self.all.clear 
    end

    def genre=(genre)
        @genre = genre 
        self.genre = genre unless self.genre
    end

    def self.find_by_name(name)
        Song.all.find do  |song| 
            song.name == name 
        end
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name) 
            self.find_by_name(name) 
        else
            self.create(name)
        end
    end


    def self.new_from_filename(filename)
        song_name = filename.split("-")[1].strip
        artist_name = filename.split("-")[0].strip
        genre_name =  filename.split("-")[2].split(".")[0].strip

        new_artist = Artist.find_or_create_by_name(artist_name)
        new_genre = Genre.find_or_create_by_name(genre_name)
        new_song =  Song.new(song_name, new_artist, new_genre)
        new_song
    end


    def self.create_from_filename(filename)
        new_instance = self.new_from_filename(filename)
        new_instance.save
    end

end


