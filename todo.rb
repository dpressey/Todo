require 'data_mapper'
require 'sinatra'
require 'shotgun'


#=========================================================================
#============================ SETUP DATABASE =============================
#=========================================================================


DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'sqlite://#{Dir.pwd}/database.db')

#=========================================================================
#================================== MODELS ===============================
#=========================================================================

class List
	include DataMapper::Resource

	property :id 			,  	Serial
	property :item			,  	Text 
	property :created_at	,  	DateTime
	property :updated_at	,  	DateTime
end

DataMapper.finalize


#=========================================================================
#================================== ROUTES ===============================
#=========================================================================


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
	erb :four0four
end