require 'pry'

class MusicLibraryController

  def initialize(path = './db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end

  def call

    input = ""

    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    Song.all.sort_by{|song| song.name}.each.with_index(1) do |s, index|
      puts "#{index}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by{|artist| artist.name}.each.with_index(1) do |a, index|
      puts "#{index}. #{a.name}"
    end
  end

  def list_genres
    Genre.all.sort_by{|genre| genre.name}.each.with_index(1) do |g, index|
      puts "#{index}. #{g.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    Artist.find_by_name(input).songs.sort_by{|song| song.name}.each.with_index(1){|s, index| puts "#{index}. #{s.name} - #{s.genre.name}"} if Artist.find_by_name(input)
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    Genre.find_by_name(input).songs.sort_by{|song| song.name}.each.with_index(1){|s, index| puts "#{index}. #{s.artist.name} - #{s.name}"} if Genre.find_by_name(input)
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    selected_song = Song.all.sort_by{|song| song.name}[input - 1]
    puts "Playing #{selected_song.name} by #{selected_song.artist.name}" if input > 0 && input <= Song.all.length
  end

end
