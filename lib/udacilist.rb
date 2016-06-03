class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    adding_error_check(type, options)

    type = type.downcase
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
      deleting_error_check(index)
      @items.delete_at(index - 1)
  end

  #Deletes multiple items from @items
  #selects everything but the indices
  #to be deleted
  def delete_multiple(*indices)
      @items.select!.with_index{|_,index| !(indices.include?(index + 1))}
  end

  def filter(item_type)
      selected = @items.select{|item| item.type == item_type} 
      return selected.each {|matched_item| puts matched_item.details} unless selected.empty?
      return puts "Could not find any results of type #{item_type}"
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  private

  def valid_type?(type)
      ["todo","event","link"].any? {|type_item| type_item == type}
  end

  def adding_error_check(type, options = {})
    valid_type = valid_type?(type)
    raise UdaciListErrors::InvalidItemType, "#{type} is not recognised" if !valid_type

    if options[:priority]
        valid_priority = ["low","medium","high"].any? {|priority| priority == options[:priority]}
        raise UdaciListErrors::InvalidPriorityValue, "Priority #{options[:priority]} not recognised" if !valid_priority
    end
  end

  def deleting_error_check(index)
      raise UdaciListErrors::IndexExceedsListSize, "Entry at index:#{index} not found" if (@items.length < index) 
  end
end
