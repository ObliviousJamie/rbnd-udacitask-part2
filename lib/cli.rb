class Cli
    attr_reader :cli_interface, :list

    def initialize(list)
        @cli_interface = HighLine.new
        @list = list
        create_new_ask
    end

    def create_new_ask
        types = ["todo","link","event"]
        type = cli_interface.ask "Would you like a todo,event or link"
        type = type.downcase
        raise InvalidItemType, "Type not found" unless types.include?(type)
        make_type(type)
    end

    def make_type(type)
        if type == "todo"
            desc = cli_interface.ask "What is the task"
            due = cli_interface.ask "When is it due?"
            priority = cli_interface.ask "How important is it? low, medium or high?"
            list.add(type, desc ,due:due, priority:priority)
        elsif type == "link"
            url = cli_interface.ask "What is the url?"
            site = cli_interface.ask "What is the site?"
            list.add(type, url,site_name: site)
        else
            desc = cli_interface.ask "What is the event?"
            date_start = cli_interface.ask "What is the start date?"
            date_end = cli_interface.ask "What is the end date?"
            list.add(type,desc,start_date:date_start,end_date:date_end)
        end
        puts "Printing new list with changes"
        puts list.all
    end
end
