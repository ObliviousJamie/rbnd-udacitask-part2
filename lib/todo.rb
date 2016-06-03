class TodoItem
  include Listable
  attr_reader :description , :type
  attr_accessor :priority, :due

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @type = "todo"
  end
  def details
    format_description(@description, type:@type) + "due: " +
    format_date(date:@due , is_due:true) +
    format_priority(@priority)
  end
end
