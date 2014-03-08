require 'sinatra'
require 'rest-client'
require 'json'
require 'uri'

CLIENT_ID = ENV['GISTBOARD_CLIENT_ID']
CLIENT_SECRET = ENV['GISTBOARD_SECRET_ID']

get '/' do
	gist1 = { user: "jhulley" ,
	 file: "myrubyfile.rb" ,
	 url: "http://github.com/ruby",
	 num_comments: 3
	}

	gist2 = { user: "jhulley" ,
	 file: "myhtmlfile.html" ,
	 url: "http://github.com/html",
	 num_comments: 5
	}

	gist3 = { user: "jhulley" ,
	 file: "mymarkdownfile.md" ,
	 url: "http://github.com/markdown",
	 num_comments: 9
	}

	gist_container = [gist1 , gist2 , gist3]

  erb :index, locals: { gist_container: gist_container }
end

get '/auth' do 
	query_params = {
		client_id: CLIENT_ID,
		scope: "gist", 
		#redirect_uri: "http://localhost/4567"
	}
	query_string = URI.encode_www_form(query_params)
	redirect "https://github.com/login/oauth/authorize?#{query_string}"
end

get '/callback' do
	code = params['code']
	response = RestClient.post('https://github.com/login/oauth/access_token', 
													{:client_id => CLIENT_ID,
                           :client_secret => CLIENT_SECRET,
                           :code => code},
                           :accept => :json)
	token = JSON.parse(response.body)['access_token']
end


