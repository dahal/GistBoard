require 'sinatra'
require 'rest-client'
require 'json'

# GIST_BOARD_CLIENT_ID = ENV['61d8e9d421cca2314136']
CLIENT_ID = ENV['GISTBOARD_CLIENT_ID']

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
	redirect "https://github.com/login/oauth/authorize?scope=gist,user:email&client_id=#{CLIENT_ID}&redirect_uri=http://localhost:4567/callback"
end
