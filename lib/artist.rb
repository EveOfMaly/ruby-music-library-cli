require 'pry'

class Artist

    extend Concerns::Findable

    attr_accessor :name, :artist 

    @@all = []

    def initialize(name)
        @name = name 
    end

    def save 
        self.class.all << self 
    end

    def self.create(new_song)
        new_instance = Artist.new(new_song)
        new_instance.save
        new_instance
    
    end

    def self.all 
        @@all
    end

    def self.destroy_all
        self.all.clear 
    end

    def songs 
        Song.all 
    end

    def add_song(song)
        song.artist = self unless song.artist 
    end

    #returns a collection of songs associated with the artist instant 
    def list_genre
        Song.all.select {|song|song.artist == self }
    end

    #returns a collection of genres for all artist songs 
    def genres
        collection = []
        list_genre.each do |song| 
           collection << song.genre 
        end
        collection.uniq
    end 

    

end 
        