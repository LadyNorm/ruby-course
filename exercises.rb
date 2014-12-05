
module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    if str != 'wishes'
      return str + str + str
    else
      return "nope"
    end
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    return array.count
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    if array.count >= 2
      return array[1]
    else
      return "No second element"
    end
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    sum = array.inject{|sum, x| sum + x}

    if array.count == 0
      return 0
    end
    return sum
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    if array.count == 0
      return nil
    end

    ans = array.max
    return ans
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    array.each do |x|
      puts x
    end
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    if array[-1] == 'panda'
      array[-1] = 'godzilla'
    else array[-1] = 'panda'
    end
    return array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    if array.include? str
      array.push(str)
    end
    return array
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    people.each do |x|
      puts "#{x[:name]} is a #{x[:occupation]}"
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(year)
    ((year % 400 == 0 || year % 100 != 0) && year % 4 == 0) ? true : false
  end

  # Exercise 10
  #  - Returns "happy hour" if it is between 4 and 6pm
  #    Otherwise, returns "normal prices"
  # Hint: Read the "Stubbing" documentation on the Learn app.
  def self.ex10
    current_time = Time.now
    if current_time.hour >= 16 && current_time.hour <= 18
      return "happy hour"
    else
      return "normal prices"
    end
  end


end

module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occures the most # of times as its value.
  #    :least => the string(s) that occures the least # of times as its value.
  #  - If any tie for most or least, return an array of the tying strings.
  #
  # Example:
  #   result = Extensions.extremes(['x', 'x', 'y', 'z'])
  #   expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  #
  def self.extremes(array)
    # TODO
  end
end
