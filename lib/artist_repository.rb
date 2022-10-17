require_relative './artist'

class ArtistRepository
  def record_to_artist(record)
    artist = Artist.new
    artist.id = record['id'].to_i
    artist.name = record['name']
    artist.genre = record['genre']
    artist
  end

  def all
    sql_query = 'SELECT * FROM artists;'
    result_set = DatabaseConnection.exec_params(sql_query, [])
    result_set.map { |record| record_to_artist(record) }
  end
end
