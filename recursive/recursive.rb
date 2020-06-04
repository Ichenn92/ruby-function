require 'pry'

def factorial(n, fact = 1.0)
  return 1 if n == 0
  return fact.to_i if n == 1
  return 'impossible' if n < 1
  fact += 1
  factorial(n / fact, fact)
end

def palindrome(word)
  if word.length == 1 || word.length == 0
    true
  else
    word[0] == word[-1] ? palindrome(word[1..-2]) : false
  end
end

def beer_bottle(n)
  if n == 0
    puts 'no more bottles of beer on the wall'
  else
    puts "#{n} bottles of beer on the wall"
    bottles(n - 1)
  end
end

def flatten(array, result = [])
  array.each do |element|
    element.kind_of?(Array) ? flatten(element, result) : result << element
  end
  result
end

def int_to_rom(i, str = '')
  roman_mapping = {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I'
  }

  if i == 0
    str
  else
    a = roman_mapping.keys.detect { |k| k - i <= 0 }
    str << roman_mapping[a]
    int_to_rom(i - a, str)
  end
end

def fibs(n)
  fib = [0, 1]
  if fib.any? { |x| x == n }
    return n
  else
    (2..n).each { |n| fib << fib[-1] + fib[-2] }
  end
  fib[-1]
end

def fibonacci(n)
  (0..1).any? { |x| x == n } ? n : fibonacci(n - 1) + fibonacci(n - 2)
end

def merge_sort(arr, arr_A = [], arr_B = [], arr_fin)
  if arr.length == 1
    return arr[0]
  else
    # binding.pry
    arr_A << merge_sort(arr.slice!(0, arr.length / 2)
    arr_B << merge_sort(arr)
    # binding.pry
    if arr_A.any? && arr_B.any?
      arr_fin << arr_A[0] < arr_B[0] ? arr_A.shift : arr_B.shift
    elsif arr_A.empty?
      arr_fin << arr_B.shift
    elsif arr_B.empty?
      arr_fin << arr_A.shift
    end
  end
  arr_fin
end

p merge_sort [5, 2]
p merge_sort [5, 2, 7, 11]
