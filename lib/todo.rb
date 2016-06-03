class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end
  def details
    format_description(@description, type:"todo") + "due: " +
    format_date(date:@due , is_due:true) +
    format_priority(@priority)
  end
end
