#!/usr/bin/ruby

require 'bundler/setup'
Bundler.require

opts = Trollop::options do
  opt :all, "List All Tasks", :default => false
  opt :database, "Specify Task Database", :default => "#{$HOME}/.simple_todo.sqlite3"
end

#puts opts.inspect

#ActiveRecord::Base.establish_connection(
#  :adapter => "sqlite3",
#  :database => opts[:database]
#)

# connect to database.  This will create one if it doesn't exist
MY_DB_NAME = "my.db"
MY_DB = SQLite3::Database.new(MY_DB_NAME)

# get active record set up
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => MY_DB_NAME)

# create your AR class
class Update < ActiveRecord::Base

end

# do a quick pseudo migration.  This should only get executed on the first run
if !Update.table_exists?
  ActiveRecord::Base.connection.create_table(:updates) do |t|
    t.column :account_name, :string
    t.column :last_update_time, :timestamp
    t.column :last_update_id, :integer
  end
end
