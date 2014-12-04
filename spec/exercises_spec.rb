require "./exercises.rb"

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
    expect(ans). to eq ["cat", "apple", "panda"]
  end

end