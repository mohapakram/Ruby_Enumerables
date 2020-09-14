require_relative "../enumerables.rb"

describe "Enumerable" do
    let (:array) { [1, 2, 3, 4] }
    let (:answer) { [] }
  
    describe "#my_each" do
    it "iterates through an array" do
        array.my_each { |item| answer << item } 
        expect(answer).to eq([1,2,3,4])
    end    
 end
  

 end