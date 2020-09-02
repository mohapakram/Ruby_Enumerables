require "../enumerables"

describe Enumerable do 
  let(:num_array){ Array.new([1,2,3,4,5])}
  let(:bool_array){Array.new([true, true, true])}
  let(:num_range){(5..10)}
  let(:strings_array) {%w{ cat sheep bear }}
 describe "#my_each" do 
    it "If no block is given, an enumerator is returned instead." do 
      expect(num_array.my_each).to be_an Enumerator
    end

    it "Calls block with one argument, for each item in enum." do
        expect(num_array.my_each { |item| item*2 }).to eql(num_array)
    end
 end

  describe "#my_each_with_index" do 
    it "If no block is given, an enumerator is returned instead." do 
      expect(num_array.my_each).to be_an Enumerator
    end

    it "Calls block with two arguments, the item and its index, for each item in enum." do
        expect(num_array.my_each { |item, index| item*2 }).to eql(num_array)
    end
   end

  describe "#my_select" do 
    it "If no block is given, an enumerator is returned instead." do 
      expect(num_array.my_each).to be_an Enumerator
    end

    it "Returns an array containing all elements of enum for which the given block returns a true value." do
        expect(num_array.select { |num|  num.even?  }).to eql([2, 4])
    end   
   end

  describe "#my_all?" do 
    it "If the block is not given, return true when none of the collection members are false or nil." do 
      expect(bool_array.my_all?).to eql(true)
    end

    it "Passes each element of the collection to the given block. The method returns true if the block never returns false or nil." do
        expect(num_array.my_all? { |num|  num.even?  }).to eql(false)
    end
  end

  describe "#my_any?" do 
    it "If the block is not given, return true when none of the collection members are false or nil." do 
      expect(bool_array.my_any?).to eql(true)
    end

    it "Passes each element of the collection to the given block. The method returns true if the block ever returns a value other than false or nil." do
        expect(num_array.my_any? { |num|  num.even?  }).to eql(true)
    end
  end

  describe "#my_count" do 
    it "Returns the number of items in enum through enumeration." do 
      expect(bool_array.my_count).to eql(3)
    end

     it "If an argument is given, the number of items in enum that are equal to item are counted. " do 
      expect(num_array.my_count(2)).to eql(1)
    end

    it "If a block is given, it counts the number of elements yielding a true value." do
        expect(num_array.my_count { |num|  num.even?  }).to eql(2)
    end
  end

   describe "#my_map" do 
    it "If no block is given, an enumerator is returned instead." do 
      expect(num_array.my_map).to be_an Enumerator
    end

     it "Returns a new array with the results of running block once for every element in enum " do 
      expect(num_array.my_map{|item| item + 1}).to eql([2,3,4,5,6])
    end
  end

  describe "#my_inject" do 
   it "Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator." do 
      expect(num_range.my_inject(:+)).to eql(45)
    end

  it "If you specify a block, then for each element in enum the block is passed an accumulator value (memo) and the element." do 
      expect(num_range.my_inject { |sum, n| sum + n } ).to eql(45)
    end


   it "If you specify a symbol instead, then each element in the collection will be passed to the named method of memo." do 
      expect(num_range.my_inject(1,:*)).to eql(151200)
    end

    it "If no initial value for memo, then the first element of collection is used as the initial value of memo." do 
      expect(strings_array.my_inject { |memo, word| memo.length > word.length ? memo : word}).to eql("sheep")
    end
  end

end


