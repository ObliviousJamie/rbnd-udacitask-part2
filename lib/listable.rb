module Listable
  # Listable methods go here
  def format_description(description)
      "#{description}".ljust(30)
  end

 def format_date(options ={})
      start_date = options[:date]
      end_date = options[:end_date]
      dates = start_date.strftime("%D") if start_date
      dates << " -- " + end_date.strftime("%D") if end_date
      dates = "N/A" if !dates
      dates = "No due date" if (options[:is_due] && !start_date) 
    return dates
 end


 def format_priority(priority)
     value = " ⇧".colorize(:red) if priority == "high"
     value = " ⇨".colorize(:light_yellow) if priority == "medium"
     value = " ⇩".colorize(:blue) if priority == "low"
     value = "" if !priority
    return value
 end

 
end
