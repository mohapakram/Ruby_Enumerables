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

     describe "#my_each_with_index" do
        it "passes through each items and index and passes a block" do
           array.my_each_with_index { |item, index| answer << item ; answer << index}
           expect(answer).to eq([1, 0, 2, 1, 3, 2, 4, 3])
         end
       end

  

 end