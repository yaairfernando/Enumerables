# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength,
module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_each
    self_item = self
    if block_given?
      self_item.size.times do |i|
        yield(self_item[i])
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    self_item = self
    if block_given?
      i = 0
      while self_item.size > i
        yield(self_item[i], i)
        i += 1
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    self_item = self
    if block_given?
      rst = []
      self_item.my_each { |i| rst.push(i) if yield(i) }
      rst
    else
      to_enum(:my_select)
    end
  end

  def my_all?(pattern = nil)
    y = true
    self_item = self
    if block_given?
      self_item.my_each { |x| y = false unless yield(x) }
    elsif pattern
      self_item.my_each { |x| y = false unless pattern == x }
    elsif pattern.is_a? Regexp
      self_item.my_each { |x| y = false unless x =~ pattern }
    elsif pattern.is_a? Class
      self_item.my_each { |x| y = false unless x.is_a? pattern }
    else
      self_item.my_each { |x| y = false unless x }
    end
    y
  end

  def my_any?(pattern = nil)
    y = false
    self_item = self
    if block_given?
      self_item.my_each { |x| y = true if yield(x) }
    elsif pattern
      self_item.my_each { |x| y = true if pattern == x }
    elsif pattern.is_a? Regexp
      self_item.my_each { |x| y = true if x =~ pattern }
    elsif pattern.is_a? Class
      self_item.my_each { |x| y = true if x.is_a? pattern }
    else
      self_item.my_each { |x| y = true if x }
    end
    y
  end

  def my_none?(pattern = nil)
    y = true
    self_item = self
    if block_given?
      self_item.my_each { |x| y = false if yield(x) }
    elsif pattern
      self_item.my_each { |x| y = false if pattern == x }
    elsif pattern.is_a? Regexp
      self_item.my_each { |x| y = false if x =~ pattern }
    elsif pattern.is_a? Class
      self_item.my_each { |x| y = false if x.is_a? pattern }
    else
      self_item.my_each { |x| y = false if x }
    end
    y
  end

  def my_count(args = nil)
    count = 0
    self_item = self
    if args
      self_item.my_each { |x| count += 1 if x == args }
    elsif block_given?
      self_item.my_each { |x| count += 1 if yield(x) }
    else
      count = self_item.size
    end
    count
  end

  def my_map
    arr = []
    my_each do |x|
      return to_enum(:my_map) unless block_given?

      arr << yield(x) || arr << proc.call(i) if block_given?
    end
    arr
  end

  def my_inject(*args)
    rst, sym = inj_param(*args)
    arr = rst ? to_a : to_a[1..-1]
    rst ||= to_a[0]
    if block_given?
      arr.my_each { |i| rst = yield(rst, i) }
    elsif !sym.nil
      arr.my_each { |i| rst = rst.public_send(sym, i) }
    end
    rst
  end

  def inj_param(*args)
    rst, sym = nil
    args.my_each do |arg|
      rst = arg if arg.is_a? Numeric
      sym = arg unless arg.is_a? Numeric
    end
    [rst, sym]
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:enable Metrics/ModuleLength
