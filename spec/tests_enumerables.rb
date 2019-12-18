# frozen_string_literal: true

require './enumerables.rb'
RSpec.describe Enumerable do
  describe '#my_each' do
    let(:arr) { [1, 2, 3, 4] }

    it 'when a block is not given' do
      expect(arr.my_each).to_not eq(Array)
    end

    it 'when a block is given and the array contains symbols' do
      arr2 = %i[num name last_name]
      expect(arr2.my_each { |x| x }).to eq(arr2)
    end

    context 'when trying to modify the block' do
      it { expect(arr.my_each { |x| x + 2 }).to eq(arr) }
    end

    it 'when printing inside the block' do
      expect(arr.my_each { |x| print x + 1 }).to eq(arr)
    end

    it 'when passing a proc' do
      my_proc = proc { |x| x * 2 }
      expect(arr.my_each(&my_proc)).to eq(arr)
    end
  end

  describe '#my_each_with_index' do
    let(:arr) { [1, 2, 3, 4] }

    it 'when a block is not given' do
      expect(arr.my_each_with_index).to_not eq(Array)
    end

    it 'when a block is given and the array contains symbols' do
      arr2 = %i[num name last_name]
      expect(arr2.my_each_with_index { |x, i| print x, i }).to eq(arr2)
    end

    it 'when given only one parameter' do
      expect(arr.my_each_with_index { |x| x }).to eq(arr)
    end

    it 'when given nil elements' do
      arr3 = [nil, nil, nil]
      expect(arr3.my_each_with_index { |x| x }).to eq(arr3)
    end

    context 'when trying to modify the block' do
      it { expect(arr.my_each_with_index { |x, i| x + i + 2 }).to eq(arr) }
    end

    it 'when printing inside the block different items' do
      arr4 = [1, 2, 3, 'hi']
      expect(arr4.my_each_with_index { |x, i| print "#{x} #{i}" }).to eq(arr4)
    end

    it 'when passing a proc' do
      my_proc = proc { |x, i| x * 2 + i }
      expect(arr.my_each_with_index(&my_proc)).to eq(arr)
    end
  end
end
