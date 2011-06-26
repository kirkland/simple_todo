class Task < ActiveRecord::Base
  def complete!
    update_attribute(:status, 'complete')
  end

  class << self
    def print_all
      Task.all.each do |t|
        puts "#{t.id}: #{t.content}"
      end
    end

    def print_all_incomplete
      Task.incomplete.each do |t|
        puts "#{t.id}: #{t.content}"
      end
    end

    def incomplete
      where('status != ?', 'complete')
    end
  end
end
