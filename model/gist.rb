# v0.1
require 'date'
require 'action_view'
include ActionView::Helpers::DateHelper


class Gist
  attr_reader :filename, :url, :id, :num_of_comments, :most_recent_comment_date
  
  def initialize( filename, url, id, num_of_comments, most_recent_comment_date)  
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

  def time_ago
    return  time_ago_in_words(most_recent_comment_date) 
  end
end