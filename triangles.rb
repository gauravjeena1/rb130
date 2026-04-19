def is_a_triangle?(sides)
  if sides.any? { |side| side.zero? }

end

def which_triangle(*sides_array)
  if sides_array.any? { |side| side.zero? } && 
end


p which_triangle(3,5,6)
p which_triangle(4,4,4)
p which_triangle(0,6,7)
p which_triangle(4,4,6)
p which_triangle(1,2,1)