require 'data_mapper'
require 'sinatra'
require 'shotgun'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'sqlite://#{Dir.pwd}/database.db')

