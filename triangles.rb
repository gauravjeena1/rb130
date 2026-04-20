class Triangle
  attr_reader :sides

  def initialize(*sides)
    @sides = sides
    raise ArgumentError, "Invalid triangle" unless is_a_triangle?
    raise ArgumentError, "Expected 3 sides, given more" if sides.count > 3
  end

  def is_a_triangle?
    return false if sides.any? { |side| side < 0 }
    sides.each do |side|
      return false if (sides.sum - side) <= side
    end
    true
  end

  def type
    if sides.all? { |side| sides[0] == side }
      "equilateral" 
    elsif sides.any? { |side| sides.count(side) == 2 }
      "isosceles"
    else
      "scalene"
    end
  end
end