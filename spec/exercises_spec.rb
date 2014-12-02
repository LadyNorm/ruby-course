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
  
end