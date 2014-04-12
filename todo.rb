require 'bundler/setup'

require 'data_mapper'
require 'sinatra'
require 'shotgun'
require 'dm-sqlite-adapter'
require 'dm-postgres-adapter'


#=========================================================================
#================================== MODELS ===============================
#=========================================================================

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

class List 
	include DataMapper::Resource

	property :id,	Serial
	property :content,	Text,	:required => true
	property :created_at,	DateTime
	property :updated_at,  	DateTime
end

# checks for validity in the model
DataMapper.finalize

# creates the database
List.auto_upgrade!


#=========================================================================
#================================== ROUTES ===============================
#=========================================================================

# hit the root of the application and get all 
# of the records of items from the database
# then list the in order from newest to oldest
get '/' do
	erb :index
end

# create a new object from the model, 
# insert what was wrote into the content field
# save the record to the database 
post '/' do
	i = List.new
	i.content = params[:item]
	i.created_at = Time.now
	i.updated_at = Time.now
	i.save

	redirect '/show'
end

# route that shows all the to-do items created
get '/show' do
	@lists = List.all(:order => :id.desc, :limit => 7)
	erb :show
end

# route that updates the items on the show page
put '/show' do
end

# route that deletes the items on the show page
delete '/show' do
end

# if routes are requested that don't exist
# direct users to the 404 error page
not_found do
	status 404
	erb :four0four
end
