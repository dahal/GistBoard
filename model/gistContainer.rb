# v1 

class GistContainer
  attr_reader :container
  
  def initialize()
    @container = []
  end
  
  def sort_container( attribute="most_recent_comment_date" )
    self.container.sort_by { |gist|
      gist.send( attribute )
    }
  end
  
  def add_gist( gist )
    self.container << gist 
  end
  
end