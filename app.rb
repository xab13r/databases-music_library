require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.print("\nWelcome to the music library manager!\n\n")
    @io.print("What would you like to do?\n1 - List all albums\n2 - List all artists\n\n")
    @io.print('Enter your choice: ')
    choice = @io.gets.chomp

    if choice == '1'
      @io.puts("\nHere is a list of albums:")

      albums = @album_repository.all

      output = albums.map do |album|
        "* #{album.id} - #{album.title}"
      end.join("\n")

    elsif choice == '2'
      @io.puts("\nHere is a list of artists:")

      artists = @artist_repository.all

      output = artists.map do |artist|
        "* #{artist.id} - #{artist.name}"
      end.join("\n")

    else
      output = 'Invalid choice.'
    end

    @io.puts(output)
  end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
