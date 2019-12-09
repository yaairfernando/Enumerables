# frozen_string_literal: true

module Enumerable

  def my_each
    if block_given?
      (self.size).times do |i|
        yield(self[i])
      end
    else
      to_enum(:my_each)
    end 
  end

  def my_each_with_index
    if block_given?
      i = 0;
      while self.size > i
        yield(self[i], i)
        i += 1
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      rst = []
      self.my_each { |i| rst.push(i) if yield(i) }
      rst
    else  
      to_enum(:my_select)
    end
  end

  def my_all?(pattern = nil)
    y = true
    if block_given?
      self.my_each { |x| y = false unless yield(x)}
    elsif pattern
      self.my_each { |x| y = false unless pattern == x }
    elsif pattern.is_a? Regexp
      self.my_each { |x| y = false unless x =~ pattern}
    elsif pattern.is_a? Class
      self.my_each { |x| y = false unless x.is_a? pattern}
    else
      self.my_each { |x| y = false unless x} 
    end
    y
  end

  def my_any?(pattern = nil)
    y = false
    if block_given?
      self.my_each { |x| y = true if yield(x)}
    elsif pattern
      self.my_each { |x| y = true if pattern == x }
    elsif pattern.is_a? Regexp
      self.my_each { |x| y = true if x =~ pattern}
    elsif pattern.is_a? Class
      self.my_each { |x| y = true if x.is_a? pattern}
    else
      self.my_each { |x| y = true if x} 
    end
    y
  end

  def my_none?(pattern = nil)
    y = true
    if block_given?
      self.my_each { |x| y = false if yield(x)}
    elsif pattern
      self.my_each { |x| y = false if pattern == x }
    elsif pattern.is_a? Regexp
      self.my_each { |x| y = false if x =~ pattern}
    elsif pattern.is_a? Class
      self.my_each { |x| y = false if x.is_a? pattern}
    else
      self.my_each { |x| y = false if x} 
    end
    y
  end


end

arr = [1,2,3,4,5]

puts ""
puts "ALL"
arr = [1,2,3,4]
puts arr.any? {|x| x < 0 }
puts arr.my_any? { |x| x < 0 }
puts arr.none? {|x| x }
puts arr.my_none? {|x| x}






