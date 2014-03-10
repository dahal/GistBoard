# v0.1
require 'date'


class Gist
  attr_reader :filename, :url, :id, :num_of_comments, :most_recent_comment_date
  
  def initialize( filename, url, id, num_of_comments, most_recent_comment_date=DateTime.new(1986,10,23))  
    @filename                    = filename
    @url                         = url
    @id                          = id
    @num_of_comments             = num_of_comments
    @most_recent_comment_date    = most_recent_comment_date
  end
  
  def short_filename
    if @filename.length > 30
  	 return @filename.slice(0...30) << '...'
    else 
      return @filename
    end
  end

  # def insert_fake_dates
  #   if !most_recent_comment_date
  #     @most_recetn_comment_date = Date.new(1986,10,23)
  #   end
  # end
end