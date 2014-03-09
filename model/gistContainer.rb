# v0.1 

class GistContainer
  attr_reader :container, :user
  
  def initialize( user )
    @container = []
    @user      = user
  end

  def sort_container( key="most_recent_comment_date" )
    @container.map { |gist|
      gist.send( key ) 
    } 
  end
  
  def add_gist( gist )
    @container << gist 
  end
  
  def count_gist
    @container.length
  end
  
  def comment_sum
    # This should be considered for revision, perhaps to reduce. 
    total = 0
    @container.each { |gist| total += gist.num_of_comments }
    return total
  end 
  
end
