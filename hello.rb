#!/usr/bin/ruby

require 'trollop'
opts = Trollop::options do
  opt :all, "List All Tasks", :default => false
  opt :file, "Specify Task Database", :default => "#{$HOME}/.simple_todo.sqlite3"
end

puts opts.inspect
