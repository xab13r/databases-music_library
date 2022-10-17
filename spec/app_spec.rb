require_relative '../app'

def reset_artist_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

def reset_album_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do
    reset_artist_table
    reset_album_table
  end

  context 'When 1 is selected' do
    it 'prints out a list of all albums' do
      io = double(:io)
      database = 'music_library_test'
      album_repository = double(:album_repository)
      artist_repository = double(:artist_repository)

      album_1 = double(:album, id: 1, title: 'The Fragile')
      album_2 = double(:album, id: 2, title: '1989')

      application = Application.new(database, io, album_repository, artist_repository)
      expect(io).to receive(:print).with("\nWelcome to the music library manager!\n\n")
      expect(io).to receive(:print).with("What would you like to do?\n1 - List all albums\n2 - List all artists\n\n")
      expect(io).to receive(:print).with('Enter your choice: ')
      expect(io).to receive(:gets).and_return('1')
      expect(io).to receive(:puts).with("\nHere is a list of albums:")
      expect(album_repository).to receive(:all).and_return([album_1, album_2])

      expect(io).to receive(:puts).with("* 1 - The Fragile\n* 2 - 1989")

      application.run
    end
  end

  context 'When 2 is selected' do
    it 'prints out a list of all artists' do
      io = double(:io)
      database = 'music_library_test'
      album_repository = double(:album_repository)
      artist_repository = double(:artist_repository)

      artist_1 = double(:album, id: 1, name: 'Nine Inch Nails')
      artist_2 = double(:album, id: 2, name: 'Taylor Swift')

      application = Application.new(database, io, album_repository, artist_repository)
      expect(io).to receive(:print).with("\nWelcome to the music library manager!\n\n")
      expect(io).to receive(:print).with("What would you like to do?\n1 - List all albums\n2 - List all artists\n\n")
      expect(io).to receive(:print).with('Enter your choice: ')
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with("\nHere is a list of artists:")
      expect(artist_repository).to receive(:all).and_return([artist_1, artist_2])

      expect(io).to receive(:puts).with("* 1 - Nine Inch Nails\n* 2 - Taylor Swift")

      application.run
    end
  end

  it 'prints out a message when choice is not 1 or 2' do
    io = double(:io)
    database = 'music_library_test'
    album_repository = double(:album_repository)
    artist_repository = double(:artist_repository)

    application = Application.new(database, io, album_repository, artist_repository)
    expect(io).to receive(:print).with("\nWelcome to the music library manager!\n\n")
    expect(io).to receive(:print).with("What would you like to do?\n1 - List all albums\n2 - List all artists\n\n")
    expect(io).to receive(:print).with('Enter your choice: ')
    expect(io).to receive(:gets).and_return('A')
    expect(io).to receive(:puts).with('Invalid choice.')
    application.run
  end
end
