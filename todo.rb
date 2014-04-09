require 'data_mapper'
require 'sinatra'
require 'shotgun'
require 'sqlite3'


#=========================================================================
#============================ SETUP DATABASE =============================
#=========================================================================


DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'sqlite:todo.db')

#=========================================================================
#================================== MODELS ===============================
#=========================================================================

class List 
	include DataMapper::Resource
	include Enumerable
	
	def each &block
	end

	property :id 			,  	Serial
	property :content		,  	Text 	, :required => true
	property :created_at	,  	DateTime
	property :updated_at	,  	DateTime
end

DataMapper.auto_migrate!


#=========================================================================
#================================== ROUTES ===============================
#=========================================================================


get '/' do
	@items = List.all :order => :id.desc
	erb :index
end

post '/' do
	i = List.new
	i.content = params[:item]
	i.created_at = Time.now
	i.updated_at = Time.now
	i.save

	redirect '/show'
end

get '/show' do
	erb :show
end

get '/about' do
	erb :about
end

not_found do
	status 404
	erb :four0four
end