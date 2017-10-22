require_relative 'quick_sort'

class Array
  def kth_smallest(k)

  end
end

k = 3
[9,1,2,8,3,7,4,5,6]

# pick pivot and do one partition step
# pick partition that includes index k - 1
# return when partion index places something in k (returns partion index == k)
# on average each step will have the array size

[1,2,8,3,7,4,5,6,9]
[---------------]
[1,2,8,3,7,4,5,6,9]
  [-------------]
[1,2,8,3,7,4,5,6,9]
    [-----------]
[1,2,3,7,4,5,6,8,9]
      [---------]
[1,2,3,4,5,6,7,8,9]
      [-----]

# quadtree - collision detection