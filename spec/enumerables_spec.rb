require "../enumerables"

describe Enumerable do 
  let(:num_array){ Array.new([1,2,3,4,5])}
    
 describe "#my_each" do 
    it "If no block is given, an enumerator is returned instead." do 
      expect(num_array.my_each).to be_an Enumerator
    end

    it "Calls block with one argument, for each item in enum." do
        expect(num_array.my_each { |item| item*2 }).to eql(num_array)
    end
 end
end


