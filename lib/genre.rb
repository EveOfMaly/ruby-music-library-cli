class Genre

    extend Concerns::Findable
    
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name 
    end

    def save 
        @@all << self 
    end

    def self.create(new_song)
        new_instance = Genre.new(new_song)
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

    def genre
        Song.all.detect {|song| song.genre == self }
    end

    #returns a collection of songs associated with genre instance 
    def artist_list 
        Song.all.select {|song| song.genre == self }
    end 

    #returns a collection of artists for all genre songs 
    def artists
        collection = []
        artist_list.each do |song| 
            collection << song.artist
        end 
        collection.uniq
    end 



end