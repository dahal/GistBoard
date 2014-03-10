# v0.1


class Gist
  attr_reader :filename, :url, :id, :num_of_comments, :most_recent_comment_date
  
  def initialize( filename, url, id, num_of_comments, most_recent_comment_date )  
    @filename                    = filename
    @url                         = url
    @id                          = id
    @num_of_comments             = num_of_comments
    @most_recent_comment_date    = most_recent_comment_date
  end
  
  def short_filename
  	return filename.slice(0...30) << '...'
  end
end