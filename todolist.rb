class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise TypeError, "Can only add ToDo objects" unless todo.instance_of? Todo
    @todos << todo
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def shift
    @todos.shift
  end

   def last
    @todos.last
  end

  def to_a
    @todos.each_with_object([]) { |todo, array| array << todo }
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    @todos.fetch(index).done!
  end

  def mark_undone_at(index)
    @todos.fetch(index).undone!
  end

  def done!
    @todos.each_index { |index| mark_done_at(index) }
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete(item_at(index))   
    # @todos.delete_at(index)        # this doesnt work for list.remove_at(100)    # raises IndexError
  end

  def to_s
    "---- #{title} ----\n" + @todos.map { |todo| todo.to_s }.join("\n")
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    temp = TodoList.new(title)
    each do |todo|
      temp << todo if yield(todo)
    end
    temp
  end

  def find_by_title(title)
    each do |todo|
      return todo if todo.title == title
    end
    nil
  end

  def all_done
    select do |todo|
      todo.done?
    end
  end

  def all_not_done
    select do |todo|
      !todo.done?
    end
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    each do |todo|
      todo.done!
    end
  end

  def mark_all_undone
    each do |todo|
      todo.undone!
    end
  end

end

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end


todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
p list << todo1

=begin
Test
# ----- setup -----
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
p list << todo1
list << todo2
list << todo3

# ----- initial state -----
puts "Initial list:"
puts list
puts "-" * 40

# ----- test find_by_title -----
puts "find_by_title('Clean room') should be the 'Clean room' todo:"
p list.find_by_title("Clean room")  # expect a Todo object with title "Clean room"

puts "find_by_title('No such') should be nil:"
p list.find_by_title("No such")     # expect nil
puts "-" * 40

# ----- test all_done / all_not_done before changes -----
puts "all_done (before marking anything) should be empty:"
puts list.all_done.to_s

puts "all_not_done (before marking anything) should contain all three:"
puts list.all_not_done.to_s
puts "-" * 40

# ----- test mark_done -----
puts "Mark 'Clean room' as done:"
list.mark_done("Clean room")
puts list
puts "-" * 40

# verify all_done / all_not_done now
puts "all_done should contain only 'Clean room':"
puts list.all_done.to_s

puts "all_not_done should contain 'Buy milk' and 'Go to gym':"
puts list.all_not_done.to_s
puts "-" * 40

# ----- test mark_all_done -----
puts "Mark all as done:"
list.mark_all_done
puts list
puts "-" * 40

puts "all_not_done after mark_all_done should be empty:"
puts list.all_not_done.to_s
puts "-" * 40

# ----- test mark_all_undone -----
puts "Mark all as undone:"
list.mark_all_undone
puts list
puts "-" * 40

puts "all_done after mark_all_undone should be empty:"
puts list.all_done.to_s

list.mark_done("Does not exist")
=end