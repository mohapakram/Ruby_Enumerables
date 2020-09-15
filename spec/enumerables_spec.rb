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

       describe "#my_select" do
         it "goes through each element and selects elements that meet the block condition" do
          answer = array.my_select { |item| item % 2 == 0 }
          expect(answer).to eq([2,4])
        end
        it "returns empty array if all elements do not meet the block condition" do
          answer = array.my_select { |item| item > 4 }
          expect(answer).to eq([])
        end
      end
    
      describe "#my_all?" do
        it "returns true if all elements meet the block condition" do
          answer = array.my_all? { |item| item < 5 }
          expect(answer).to be true
        end
        it "returns false if one of the elements does not meet the block condition" do
          answer = array.my_all? { |item| item != 2 }
          expect(answer).to be false
        end
      end
    
      describe "#my_any?" do
        it "returns true if at least one of the elements meets the block condition" do
          answer = array.my_any? { |item| item == 2 }
          expect(answer).to be true
        end
        it "returns false if none of the elements meet the block condition" do
          answer = array.my_any? { |item| item == 0 }
          expect(answer).to be false
        end
      end
    
      describe "#my_none?" do
        it "returns true if none of the elements meet the block condition" do
          answer = array.my_none? { |item| item == 100 }
          expect(answer).to be true
        end
        it "returns false if one of the elements meet the block condition" do
          answer = array.my_none? { |item| item == 4 }
          expect(answer).to be false
        end
      end
    
      describe "#my_count" do
        it "returns a count of how many elements meet the block condition" do
          answer = array.my_count { |item|  item > 2}
          expect(answer).to eq(2)
        end
      end
    
      describe "#my_map" do
        it "returns a new array with the elements modified by the block" do
          answer = array.my_map { |item| item + 2 }
          expect(answer).to eq([3,4,5,6])
        end
      end
    
      describe "#my_inject" do
        it "takes a parameter and yields to the block and returns the modified parameter" do
          answer = array.my_inject(0) { |item, index| item += index }
          expect(answer).to eq(10)
        end
      end

 end