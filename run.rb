#!/usr/bin/ruby

require 'bundler/setup'
Bundler.require

opts = Trollop::options do
  opt :database, "Specify Task Database", :default => "#{ENV['HOME']}/.simple_todo.sqlite3"
  opt :resetdb, "Clear out old database. Be careful!", :default => false
  opt :action, "Action", :default => 'list'
end

#puts opts.inspect

# maybe delete db first
File.delete(opts[:database]) if opts[:resetdb] && File.exist?(opts[:database])

SQLite3::Database.new(opts[:database])
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => opts[:database])

# define schema
# id column gets set up automatically
def initialize_database
  ActiveRecord::Base.connection.create_table(:tasks) do |t|
    t.column :content, :string, :limit => 256
    t.column :created_at, :timestamp
    t.column :updated_at, :timestamp
    t.column :status, :string, :limit => 32, :default => 'active'
  end
end

# models
require 'task'

# assume if this one table doesn't exist, need to make all tables
initialize_database if !Task.table_exists?

if opts[:action] == "list"
  Task.print_all
end
