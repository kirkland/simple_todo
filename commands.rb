class Commands
  class << self
    def process(global_opts, cmd_opts, cmd, rest)
      @global_opts = global_opts
      @cmd_opts = cmd_opts
      @cmd = cmd
      @rest = rest

      case @cmd
        when 'list', 'l'
          list
        when 'add', 'a'
          add
        when 'complete', 'c'
          complete
        end
    end
    
    def list
      if @cmd_opts[:all]
        Task.print_all
      else
        Task.print_all_incomplete
      end
    end
    
    def add
      if t = Task.create(:content => @rest.join(' '))
        puts "new task created: #{t.inspect}"
      else
        puts "error saving task: #{t.inspect}"
      end
    end

    def complete
      id = @rest.shift.to_i
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
