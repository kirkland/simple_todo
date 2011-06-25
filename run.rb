#!/usr/bin/ruby

require 'bundler/setup'
Bundler.require

opts = Trollop::options do
  opt :all, "List All Tasks", :default => false
  opt :database, "Specify Task Database", :default => "#{ENV['HOME']}/.simple_todo.sqlite3"
end

#puts opts.inspect

db = SQLite3::Database.new(opts[:database])
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => opts[:database])

# define schema
def initialize_database
  ActiveRecord::Base.connection.create_table(:tasks) do |t|
    t.column :content, :string, :limit => 256
  end
end

# models
require 'task'

# assume if this one table doesn't exist, need to make all tables
initialize_database if !Task.table_exists?


