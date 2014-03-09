# v0.1


class Gist
  attr_reader :file, :url, :id, :num_of_comments, :most_recent_comment_date
  
  def initialize( file, url, id, num_of_comments, most_recent_comment_date )  
    @file                     = file
    @url                      = url
    @id                       = id
    @num_of_comments          = num_of_comments
    @most_recent_comment_date = most_recent_comment_date
  end
  
end