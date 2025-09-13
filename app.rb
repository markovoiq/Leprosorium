#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	@db = SQLite3::Database.new 'leprosorium.db'
	@db.results_as_hash = true
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
		created_date TEXT,
		content	TEXT
	)'
end

get '/' do
	@results = @db.execute 'select * from Posts order by id desc--'

	erb :posts	
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

	@db.execute 'insert into Posts (content, created_date) values (?, datetime())', [@content]

	redirect to '/'
end