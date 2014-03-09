require 'digest/md5'

class User
  attr_reader :username
  
  def initialize( username, email )
    @username = username
    @email    = email
  end
  
  def get_url
    return "http://gist.github.com/#{@username}"
  end
  
  def get_gravatar_url
    hash = Digest::MD5.hexdigest(@email)
    return "http://www.gravatar.com/avatar/#{hash}"
  end
  
end