require "./exercises.rb"

describe Exercises do 
  it "return string time 3 or nope" do
    ans = Exercises.ex0("str")
    expect(ans).to eq "strstrstr"

    ans = Exercises.ex0("wishes")
    expect(ans).to eq "nope"
  end
  
end