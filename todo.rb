require 'bundler/setup'

require 'data_mapper'
require 'sinatra'
require 'shotgun'



#=========================================================================
#================================== MODELS ===============================
#=========================================================================

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
#DataMapper.setup(:default, 'sqlite:todo.db')
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

# route that gets the item to be edited
get '/:id' do
	@list = List.get(params[:id])
	erb :edit
end

# route that updates the item
put '/:id' do
	i = List.get(params[:id])
	i.content = params[:item]
	i.updated_at = Time.now
	i.save

	redirect '/show'
end	

# route that gets the item to be deleted
get '/:id/delete' do 
	@list = List.get(params[:id])
	erb :delete

end

# route that deletes the item
delete '/:id/delete' do
	i = List.get(params[:id])
	i.destroy

	redirect '/show'
end

# if routes are requested that don't exist
# direct users to the 404 error page
not_found do
	status 404
end
