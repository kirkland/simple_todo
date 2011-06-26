class Task < ActiveRecord::Base
  def complete!
    update_attribute(:status, 'complete')
  end

  def uncomplete!
    update_attribute(:status, 'active')
  end

  def print(include_status = false)
    id_space = Task.order('id DESC').limit(1).first.id.to_s.length
    print_id = id.to_s.rjust(id_space)

    puts "#{status_string if include_status}#{print_id}: #{content}"
  end
  
  def status_string
    case status
      when 'complete'
        'X '
      else
        '  '
      end
  end

  class << self
    def print_all
      Task.all.each do |t|
        t.print(true)
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
