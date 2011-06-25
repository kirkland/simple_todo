#!/usr/bin/ruby

require 'bundler/setup'
Bundler.require

COMMANDS=['list', 'add']

# global options
global_opts = Trollop::options do
  banner <<-EOM

Usage: ./run.rb [options] command (list or add)

EOM
  opt :database, "Specify Task Database", :default => "#{ENV['HOME']}/.simple_todo.sqlite3"
  opt :resetdb, "Delete old database. Be careful!", :default => false
end

cmd = ARGV.shift
cmd_opts = case cmd
  when 'list' # parse list options
    # when we need it, add another Trollop::options block here
  when 'add' # parse add options
  else
    Trollop::die "unknown subcommand #{cmd.inspect}"
  end

#puts "global_opts: #{global_opts.inspect}"
#puts "cmd_opts: #{cmd_opts.inspect}"

# maybe delete db first
File.delete(global_opts[:database]) if global_opts[:resetdb] && File.exist?(global_opts[:database])

SQLite3::Database.new(global_opts[:database])
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => global_opts[:database])

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

case cmd
  when 'list'
    Task.print_all
  when 'add'
    if t = Task.create(:content => ARGV.join(" "))
      puts "new task created: #{t.inspect}"
    else
      puts "error saving task: #{t.inspect}"
    end
  end
