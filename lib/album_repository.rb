require_relative './album'

class AlbumRepository
  def record_to_album(record)
    album = Album.new
    album.id = record['id'].to_i
    album.title = record['title']
    album.release_year = record['release_year'].to_i
    album.artist_id = record['artist_id'].to_i
    album
  end

  def all
    sql_query = 'SELECT * FROM albums;'
    result_set = DatabaseConnection.exec_params(sql_query, [])

    result_set.map { |record| record_to_album(record) }
  end
end
