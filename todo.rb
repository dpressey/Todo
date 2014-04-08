require 'data_mapper'
require 'dm-migrations'
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
	include Enumerable

	property :id 			,  	Serial
	property :content		,  	Text 
	property :created_at	,  	DateTime
	property :updated_at	,  	DateTime
end

DataMapper.finalize


#=========================================================================
#================================== ROUTES ===============================
#=========================================================================


get '/' do
	@items = List.all :order => :id.desc
	erb :index
end

post '/' do
	i = List.new
	i.content = params[:content]
	i.created_at = Time.now
	i.updated_at = Time.now
	i.save

	redirect '/'
end

get '/about' do
	"this is the about me section"
end

not_found do
	status 404
	erb :four0four
end