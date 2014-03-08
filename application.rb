require 'sinatra'
require 'rest-client'
require 'json'
require 'uri'

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
		client_id: ENV['GISTBOARD_CLIENT_ID'],
		scope: "gist", 
		#redirect_uri: "http://localhost/4567"
	}
	query_string = URI.encode_www_form(query_params)
	redirect "https://github.com/login/oauth/authorize?#{query_string}"
end

get '/callback' do
	code = params['code']
	query = {
		body: {
			client_id: ENV['GISTBOARD_CLIENT_ID'], 
			client_secret: ENV['GISTBOARD_SECRET_ID'],
			code: code
		},
		headers: {
			"Accept" => "aco
			pplciation/json"
		}
	}

	response = RestClient.post("https://github.com/login/oauth/access_token", query)
	token = JSON.parse(response.body)['access_token']
	erb :authenticated, locals: { token: token }
end

