require './enumerables.rb'

RSpec.describe Enumerable do
  describe "#my_each" do
    let(:arr) { [1,2,3,4] }

    it "when a block is not given" do
      expect(arr.my_each).to_not eq(Array)
    end

    it "when a block is given and the array contains symbols" do
      arr2 = [:num, :name, :last_name]
      expect(arr2.my_each{|x| x}).to eq([:num, :name, :last_name])
    end
    
    context "when trying to modify the block" do
      it { expect(arr.my_each{|x| x + 2}).to eq(arr) }
    end

    it "when printing inside the block" do
      expect(arr.my_each{|x| print x + 1}).to eq(arr)
    end

    it "when passing a proc" do
      proc = Proc.new{|x| x * 2 }
      expect(arr.my_each(&proc)).to eq(arr)
    end

  end
end