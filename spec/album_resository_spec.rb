require 'album_repository'

def reset_album_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do
    reset_album_table
  end

  describe '#record_to_album' do
    it 'returns an Album object from record' do
      repo = AlbumRepository.new

      record = {
        'id' => '2',
        'title' => 'The Fragile',
        'release_year' => '1996',
        'artist_id' => '1'
      }

      album = repo.record_to_album(record)

      expect(album.id).to eq 2
      expect(album.title).to eq 'The Fragile'
      expect(album.release_year).to eq 1996
      expect(album.artist_id).to eq 1
    end
  end

  describe '#all' do
    it 'returns an array of Album objects' do
      repo = AlbumRepository.new

      albums = repo.all

      expect(albums.length).to eq 2
      expect(albums.first.id).to eq 1
      expect(albums.first.title).to eq 'The Fragile'
      expect(albums.first.release_year).to eq 1996
      expect(albums.first.artist_id).to eq 1

      expect(albums.last.id).to eq 2
      expect(albums.last.title).to eq '1989'
      expect(albums.last.release_year).to eq 2015
      expect(albums.last.artist_id).to eq 2
    end
  end
end
