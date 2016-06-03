class EventItem
  include Listable
  attr_reader :description, :type
  attr_accessor :start_date, :end_date

  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
    @type = "event"
  end
  def details
      format_description(@description, type:@type) + "event dates: " + format_date(date: @start_date, end_date: @end_date)
  end
end
