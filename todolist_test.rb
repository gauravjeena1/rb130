require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
    @list.done!
    assert(@list.done?)
  end

  def test_add_raise_error
    assert_raises(TypeError) { @list.add(1) }
    assert_raises(TypeError) { @list.add('hi') }
  end

  def test_add
    expected = @list.to_a + [@todo1]
    @list.add(@todo1)
    assert_equal(expected , @list.to_a)
  end

  def test_add_alias
    expected = @list.to_a + [@todo1]
    @list.<<(@todo1)
    assert_equal(expected, @list.to_a)
  end
  
  def test_item_at
    find_todo = @list.item_at(1)
    assert_equal(@todo2, find_todo)
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_mark_done_at
    @list.mark_done_at(1)
    assert_equal(true, @list.item_at(1).done?)
    assert_equal(false, @list.item_at(2).done?)
    assert_raises(IndexError) { @list.mark_done_at(3) }
  end

  def test_mark_undone_at
    @list.mark_all_done
    @list.mark_undone_at(1)
    assert_equal(false, @list.item_at(1).done?)
    assert_equal(true, @list.item_at(2).done?)
  end

  def test_mark_done
    @list.mark_done("Buy milk")
    assert_equal(true, @todo1.done?)
  end

  def test_done!
    @list.done!
    assert_equal(true, @list.item_at(0).done?)
    assert_equal(true, @list.item_at(1).done?)
    assert_equal(true, @list.item_at(2).done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    @list.remove_at(0)
    assert_equal([@todo2, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(4) }
  end

  def test_to_s
    expected = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    actual = @list.to_s
    assert_equal(expected, actual)
  end

  def test_to_s_2
    @todo1.done!
    expected = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    actual = @list.to_s
    assert_equal(expected, actual)
  end

  def test_to_s_3
    @list.done!
    expected = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    actual = @list.to_s
    assert_equal(expected, actual)
  end

  def test_each
    expected = []
    actual_return = (@list.each do |todo|
      expected << todo
    end)

    assert_equal(expected, @list.to_a)
    assert_equal(@list, actual_return)
  end

  def test_select
    actual = @list.select { |todo| todo == @todo1 }
    assert_equal(@list.first, actual.first)
    assert_instance_of(@list.class, actual)
    assert_equal(1, actual.size)
    assert_equal(@list.title, actual.title)
    refute_same(@list, actual)
  end
end