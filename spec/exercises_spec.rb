require "./exercises.rb"
require 'date'

describe Exercises do 
  it "return string time 3 or nope" do
    ans = Exercises.ex0("str")
    expect(ans).to eq "strstrstr"

    ans = Exercises.ex0("wishes")
    expect(ans).to eq "nope"
  end

  it "returns the number of elements in an array" do
    ans = Exercises.ex1([1, 2, 3])
    expect(ans).to eq 3
  end

  it "returns the second element in an array" do
    ans = Exercises.ex2([1, 2, 3])
    expect(ans).to eq 2
  end

  it "returns the sum of the elements in the array" do
    ans = Exercises.ex3([1, 2, 3])
    expect(ans).to eq 6
  end

  it "returns the max element in an array" do
    ans = Exercises.ex4([1, 2, 3])
    expect(ans).to eq 3

    ans = Exercises.ex4([])
    expect(ans).to eq nil
  end
  
  it "puts the elements of an array" do
    expect(STDOUT).to receive(:puts).and_return('a')
    ans = Exercises.ex5(['a'])
  end

  it "changes the last element of an array to panda, or godzilla" do
    ans = Exercises.ex6(["cat", "apple", "banana"])
    expect(ans).to eq ["cat", "apple", "panda"]
  end

  it "checks array for string, if present, adds string" do
    ans = Exercises.ex7(["cat", "dog", "banana"], "cat")
    expect(ans).to eq ["cat", "dog", "banana", "cat"]
  end

  it "prints an array of hashes of name and occupations" do
    expect(STDOUT).to receive(:puts).and_return('Nora is a developer')
    ans = Exercises.ex8([{:name => 'Nora', :occupation => 'developer'}])
  end

  it "determines if a given year is a leap year" do
    ans = Exercises.ex9(Date.new(2012))
    expect(ans).to eq(true)
  end

  it "determines if a given time is between 4 and 6 pm" do
    my_time = Time.new(2013, 03, 03, 17)
    allow(Time).to receive(:now).and_return(my_time)
  end

end