# v0.1 

class GistContainer
  attr_reader :container, :user
  
  def initialize( user )
    @container = []
    @user      = user
  end

  def sort!( key="most_recent_comment_date" )
    @container.sort_by! { |gist| gist.most_recent_comment_date.to_s }.reverse!
  end
  
  def add_gist( gist )
    @container << gist 
  end
  
  def gist_count
    @container.length
  end
  
  def comment_count
    # This should be considered for revision, perhaps to reduce. 
    total = 0
    @container.each { |gist| total += gist.num_of_comments }
    return total
  end 
  
end
