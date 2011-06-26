class Task < ActiveRecord::Base
  def complete!
    update_attribute(:status, 'complete')
  end

  def print
    id_space = Task.order('id DESC').limit(1).first.id.to_s.length
    print_id = id.to_s.rjust(id_space)

    puts "#{print_id}: #{content}"
  end

  class << self
    def print_all
      Task.all.each do |t|
        t.print
      end
    end

    def print_all_incomplete
      Task.incomplete.each do |t|
        t.print
      end
    end

    def incomplete
      where('status != ?', 'complete')
    end
  end
end
