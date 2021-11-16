require 'pry'

class MusicLibraryController

    def initialize(path = "./db/mp3s") 
        MusicImporter.new(path).import
    end

    def call 
        input = ""

        while input != "exit"
            puts "Welcome to your music library!".red
            sleep 2
            puts "To list all of your songs, enter 'list songs'.".blue
            puts "To list all of the artists in your library, enter 'list artists'.".blue
            puts "To list all of the genres in your library, enter 'list genres'.".blue
            puts "To list all of the songs by a particular artist, enter 'list artist'.".blue
            puts "To list all of the songs of a particular genre, enter 'list genre'.".blue
            puts "To play a song, enter 'play song'.".blue
            puts "To quit, type 'exit'.".blue
            sleep 2
            puts "What would you like to do?".blue

            input = gets.chomp 

            case input 
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
                sleep 1
            when 'list genres'
                list_genres
                sleep 1
            when 'list artist'
                list_songs_by_artist
                sleep 1
            when 'list genre'
                list_songs_by_genre
                sleep 1
            when 'play song'
                play_song
                sleep 1
            end
        end     
    end


    def list_songs
        song_sorted = Song.all.sort {|x,y|  x.name <=> y.name}
        song_sorted.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}".green
        end
    end


    def list_artists
        artists_sorted = Artist.all.sort {|x,y|  x.name <=> y.name}
        artists_sorted.each.with_index(1) do |artist, index|
            puts "#{index}. #{artist.name}".green
        end
    end

    def list_genres
        genre_sorted = Genre.all.sort {|x,y|  x.name <=> y.name}
        genre_sorted.each.with_index(1) do |genre, index|
            puts "#{index}. #{genre.name}".green
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:".blue
        input = gets.chomp 
        songs_by_artist_list = Song.all.select {|song| song.artist.name == input}
        songs_by_artist_sorted = songs_by_artist_list.sort {|x,y|  x.name <=> y.name}
        songs_by_artist = songs_by_artist_sorted.each.with_index(1) do |song, index|
            puts "#{index}. #{song.name} - #{song.genre.name}".green
        end
    end


    def list_songs_by_genre
        puts "Please enter the name of a genre:".blue
        input = gets.chomp 
        genre_by_artist_list = Song.all.select {|song| song.genre.name == input}
        genre_by_artist_sorted = genre_by_artist_list.sort {|x,y|  x.name <=> y.name}
        genre_by_artist = genre_by_artist_sorted.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name}" 
        end
    end


    def play_song
        puts "Which song number would you like to play?".blue

        input = gets.strip.to_i
        if (1..Song.all.length).include?(input)
            song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
        end
        sleep 1
        puts "Playing #{song.name} by #{song.artist.name}" if song
    end


end


