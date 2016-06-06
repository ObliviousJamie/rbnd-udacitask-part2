class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end

  #Adds item to @items
  #and assigns it into the correct item
  def add(type, description, options={})
    adding_error_check(type, options)

    type = type.downcase
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  #Checks if a valid index is given
  #and deletes item
  def delete(*index)
      check_list = *index
      check_list.each do |pos|
          deleting_error_check if pos > @items.length
      end
      @items.delete_if.with_index{|_,index_given| (check_list.include?(index_given + 1))}
  end

  #Selects all items that are of a given 
  #type and returns them
  #if none are found returns a message
  def filter(item_type)
      selected = @items.select{|item| item.type == item_type} 
      return selected.each {|matched_item| puts matched_item.details} unless selected.empty?
      return puts "Could not find any results of type #{item_type}"
  end


  #Prints table of item information
  #using terminal-table gem
  def all
    title = @title
    headings = ["Position","Details"]
    rows = []
    @items.each_with_index do |item, position|
      rows << [position + 1, item.details]
    end
    puts Terminal::Table.new headings: headings, rows: rows, title: title
  end

  private

  #Returns if type given is valid
  def valid_type?(type)
      ["todo","event","link"].any? {|type_item| type_item == type}
  end

  #Checks for InvalidItemType or InvalidPriorityValue
  def adding_error_check(type, options = {})
    valid_type = valid_type?(type)
    raise UdaciListErrors::InvalidItemType, "#{type} is not recognised" if !valid_type

    if options[:priority]
        valid_priority = ["low","medium","high"].any? {|priority| priority == options[:priority]}
        raise UdaciListErrors::InvalidPriorityValue, "Priority #{options[:priority]} not recognised" if !valid_priority
    end
  end

  #Checks for errors to do with deleting values
  def deleting_error_check(index)
      raise UdaciListErrors::IndexExceedsListSize, "Entry at index:#{index} not found" if (@items.length < index) 
  end
end
