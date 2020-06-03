def merge_sort(arr, *sorted_arr)
  if arr.length <= 1
    return arr
  else
    left = merge_sort(arr.slice!(0, arr.length / 2))
    right = merge_sort(arr)
  end
  until left.empty? && right.empty?
    if left.empty? || right.empty?
      sorted_arr += (left.empty? ? right : left)
      left.clear && right.clear
    else
      sorted_arr << (left[0] < right[0] ? left.shift : right.shift)
    end
  end
  sorted_arr
end

p merge_sort([14, 4, 20, 1, 3, 7, 15, 9]) # => [1,3,4,7,9,14,15,20]
p merge_sort([6]) # => [6]
p merge_sort([]) # => [6]
p merge_sort([4, 22, 88, 1, 99, 203, 6, 16, 25]) # => [1,4,6,16,22,25,88,99,203]
