require 'sinatra'
require 'rest-client'
require 'json'
require 'uri'
require 'octokit'
require_relative 'model/gist'
require_relative 'model/gistContainer'
require_relative 'model/user'

CLIENT_ID = ENV['GISTBOARD_CLIENT_ID']
CLIENT_SECRET = ENV['GISTBOARD_SECRET_ID']

use Rack::Session::Cookie, secret: rand.to_s()

helpers do
	def authenticated?
		session[:access_token] 
	end 
end

get '/' do

	if !authenticated?
		redirect "/new_user"
	end

	begin
    client = Octokit::Client.new access_token: session[:access_token]
    client.per_page = 20
    user = client.user
  rescue => e
    redirect '/auth'
  end

	gists = client.gists
	email = client.emails.first 
	username = client.user.login
  user = User.new( username, email )
	gist_container = GistContainer.new( user )

	gists.each do |gist|
		gist_id = gist.id
		gist_comments = client.gist_comments(gist_id)
    file = gist.files.to_hash.keys.first.to_s              
    num_of_comments = gist.comments
    if num_of_comments < 1
			most_recent_comment_date = DateTime.new(1986,10,23).xmlschema.to_s
    else
			most_recent_comment_date = gist_comments.map! { |gist_comment| gist_comment.updated_at}.sort.pop
    end      
    url = "https://gist.github.com/#{user.username}/#{gist_id}"
    gist = Gist.new( file, url, gist_id, num_of_comments, most_recent_comment_date)
    gist_container.add_gist(gist)
	end
	gist_container.sort!
  erb :index, locals: { gist_container: gist_container }
end

get '/new_user' do
	erb :new_user
end

get '/auth' do 
	query_params = {
		client_id: CLIENT_ID,
		scope: "user:email"
	}
	query_string = URI.encode_www_form(query_params)
	redirect "https://github.com/login/oauth/authorize?#{query_string}"
end

# get '/test' do
# 	erb :test, :locals => { :access_token => session[:access_token]}
# end


get '/callback' do
	code = params['code']
	response = RestClient.post('https://github.com/login/oauth/access_token', 
													{:client_id => CLIENT_ID,
                           :client_secret => CLIENT_SECRET,
                           :code => code},
                           :accept => :json)
	access_token = JSON.parse(response.body)['access_token']
	session[:access_token] = access_token
	##TODO Add More shit to the session
	# client = Octokit::Client.new access_token: access_token
	# user = client.user
	# login = user.login
	# erb :test, locals: { access_token: access_token, username: login }
	redirect "/"
end


