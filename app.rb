#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	@db = SQLite3::Database.new 'leprosorium.db'
	@db.results_as_hash
	return @db
end

before do
	get_db
end

configure do
	get_db
	@db.execute 'CREATE TABLE IF NOT EXISTS Posts 
	(
		id	INTEGER PRIMARY KEY AUTOINCREMENT,
		created date	TEXT,
		content	TEXT
	)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/new' do
	erb :new
end

post '/new' do
	@content = params[:content]
	if @content.length <= 0
		@error = "Type text"
		return erb :new
	end
	
	erb @content
end