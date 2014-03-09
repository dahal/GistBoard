require 'sinatra'
require 'rest-client'
require 'json'
require 'uri'
require 'octokit'
require_relative 'model/gist'
require_relative 'model/gistContainer'

CLIENT_ID = ENV['GISTBOARD_CLIENT_ID']
CLIENT_SECRET = ENV['GISTBOARD_SECRET_ID']

use Rack::Session::Cookie, secret: rand.to_s()

helpers do
	def authenticated?
		session[:access_token] 
	end 
end

get '/' do
	# gist1 = { user: "jhulley" ,
	#  file: "myrubyfile.rb" ,
	#  url: "http://github.com/ruby",
	#  num_comments: 3
	# }

	# gist2 = { user: "jhulley" ,
	#  file: "myhtmlfile.html" ,
	#  url: "http://github.com/html",
	#  num_comments: 5
	# }

	# gist3 = { user: "jhulley" ,
	#  file: "mymarkdownfile.md" ,
	#  url: "http://github.com/markdown",
	#  num_comments: 9
	# }

	# gist_container = [gist1 , gist2 , gist3]

	if !authenticated?
		redirect "/new_user"
	end

	gist_container = GistContainer.new

	client = Octokit::Client.new access_token: session[:access_token]
	gists = client.gists
	email = client.emails.first 
	username = client.user.login
	gist_container = GistContainer.new()

	gists.each do |gist|

		gist_comments = client.gist_comments(gists.first.id)
		gist_id = gist.id
		username = gist.user.login                 
    gravatar_id = gist.user.gravatar_id
    file = gist.files.to_hash.keys.first.to_s                   
    num_of_comments = gist.comments      
    most_recent_comment_date = gist_comments.map! { |gist_comment| gist_comment.updated_at}.sort.pop 
    url = "https://gist.github.com/#{username}/#{gist_id}"

    gist_container.add_gist(Gist.new(username, gravatar_id, file, url, num_of_comments, most_recent_comment_date))

	end
	
  erb :index, locals: { gist_container: gist_container }
end

get '/new_user' do
	erb :new_user
end

get '/auth' do 
	query_params = {
		client_id: CLIENT_ID,
		scope: "gist,user:email"
	}
	query_string = URI.encode_www_form(query_params)
	redirect "https://github.com/login/oauth/authorize?#{query_string}"
end

get '/test' do
	erb :test, :locals => { :access_token => session[:access_token]}
end


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


