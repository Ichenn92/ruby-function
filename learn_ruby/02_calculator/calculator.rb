#write your code here
def add (a, b)
    a + b
end

def subtract (a, b)
    a - b
end

def sum (array)
    sum = 0
    array.each do |i|
        sum += i
    end
    return sum
end

def multiply (a, b)
    a * b
end

def power (a, b)
    a ** b
end

def factorial (a)
    return 1 if a == 0
    sum = 1
    for i in 1..a
        sum *= i
    end
    return sum
end