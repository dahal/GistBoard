# v1


class Gist
  attr_reader :username, :gravatar_id, :file, :url, :num_of_comments, :most_recent_comment_date
  
  def initialize( username, gravatar_id, file, url, num_of_comments, most_recent_comment_date )  
    @username                 = username
    @gravatar_id              = gravatar_id
    @file                     = file
    @url                      = url
    @num_of_comments          = num_of_comments
    @most_recent_comment_date = most_recent_comment_date 
  end
  
end