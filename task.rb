class Task < ActiveRecord::Base
  class << self
    def print_all
      Task.all.each do |t|
        puts "#{t.id}: #{t.content}"
      end
    end
  end
end
