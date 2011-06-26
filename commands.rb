class Commands
  class << self
    def process(global_opts, cmd_opts, cmd, rest)
      case cmd
        when 'list', 'l'
          if cmd_opts[:all]
            Task.print_all
          else
            Task.print_all_incomplete
          end
        when 'add', 'a'
          if t = Task.create(:content => ARGV.join(" "))
            puts "new task created: #{t.inspect}"
          else
            puts "error saving task: #{t.inspect}"
          end
        when 'complete', 'c'
          id = ARGV.shift.to_i
          t = Task.find(id)
          if t.nil?
            puts "no task with id #{id}"
          else
            if t.complete!
              puts "task completed: #{t.inspect}"
            else
              puts "error completing task: #{t.inspect}"
            end
          end
        end
    end
  end
end
