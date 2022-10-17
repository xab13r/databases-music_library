require 'artist_repository'

def reset_artist_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do
    reset_artist_table
  end

  describe '#record_to_artist' do
    it 'returns an Artist object from record' do
      repo = ArtistRepository.new

      record = {
        'id' => '1',
        'name' => 'Nine Inch Nails',
        'genre' => 'Industrial'
      }

      artist = repo.record_to_artist(record)

      expect(artist.id).to eq 1
      expect(artist.name).to eq 'Nine Inch Nails'
      expect(artist.genre).to eq 'Industrial'
    end
  end

  describe '#all' do
    it 'returns an array of Artist objects' do
      repo = ArtistRepository.new

      artists = repo.all

      expect(artists.length).to eq 2
      expect(artists.first.id).to eq 1
      expect(artists.first.name).to eq 'Nine Inch Nails'
      expect(artists.first.genre).to eq 'Industrial'

      expect(artists.last.id).to eq 2
      expect(artists.last.name).to eq 'Taylor Swift'
      expect(artists.last.genre).to eq 'Pop'
    end
  end
end
