# frozen_string_literal: true

require './enumerables.rb'
RSpec.describe Enumerable do
  describe '#my_each' do
    let(:arr) { [1, 2, 3, 4] }

    it 'when a block is not given' do
      expect(arr.my_each).to_not be_a(Array)
    end

    it 'when a block is given and the array contains symbols' do
      arr2 = %i[num name last_name]
      expect(arr2.my_each { |x| x }).to be_a(Array)
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
      expect(arr.my_each_with_index).to_not be_a(Array)
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

  describe '#my_select' do
    let(:arr) { [1, 2, 3, 4, 5] }

    it 'when a block is not given' do
      expect(arr.my_select).to be_a(Enumerable)
    end

    it 'when a block is given and the array contains symbols' do
      arr2 = %i[num name last_name]
      expect(arr2.my_select { |i| i.is_a? Symbol }).to eq(arr2)
    end

    it 'when given two parameter' do
      expect(arr.my_select { |x, i| x == i }).to eq([])
    end

    context 'when given a block' do
      it { expect(arr.my_select { |i| i > 2 }).to eq([3, 4, 5]) }
      it { expect(arr.my_select { |i| i < 2 }).to eq([1]) }
      it { expect(arr.my_select { |i| i == 2 }).to eq([2]) }
    end

    context 'when using an array of string' do
      arr_string = ["MXM", "USA", "RUS", "POR", "hello", "heolloeh"]
      it { expect(arr_string.my_select { |i| i == i.upcase }).to eq(["MXM", "USA", "RUS", "POR"]) }
      it { expect(arr_string.my_select { |i| i == i.reverse }).to eq(["MXM", "heolloeh"]) }
      it { expect(arr_string.my_select { |i| i.include?("R") }).to eq(["RUS", "POR"]) }
    end

    it 'when using different items' do
      ses = "a".to_sym
      s = "a".to_sym
      expect([ses,s,:att,:red,2,"w"].my_select{|i| i == :a}).to eq([:a, :a])
    end
    
  end
end
