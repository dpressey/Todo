require 'data_mapper'
require 'sinatra'
require 'shotgun'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'sqlite://#{Dir.pwd}/database.db')

get '/' do
	erb :index
end

post '/' do
	params[:input].upcase + "Say Something....I'M GIVING UP ON YOU"
end

get '/about' do
	"this is the about me section"
end

not_found do
	status 404
	erb :404
end