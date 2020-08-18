module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    each do |item|
      yield item
    end

    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    each do |item|
      yield item, index
      index += 1
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    results_array = []
    each do |item|
      next unless yield item

      results_array << item
    end
    results_array
  end

  def my_all?(pattern = nil)
    result = true
    if block_given?
      each do |item|
        result = false unless yield item
      end
    elsif pattern
      each do |item|
        result = false unless pattern.match(item)
      end
    else
      each do |item|
        result = false unless item
      end
    end
    result
  end

  def my_none?(pattern = nil)
    result = true
    if block_given?
      each do |item|
        result = false if yield item
      end
    elsif pattern
      each do |item|
        result = false if pattern.match(item)
      end
    else
      each do |item|
        result = false if item
      end
    end
    result
  end

  def my_count(number = nil)
    count = 0
    if number
      each do |i|
        count += number if i == number
      end
    end

    return length unless block_given?

    each do |i|
      count += 1 if yield i
    end
    count
  end

  def my_map(proc = nil)
    end_array = []
    item = nil
    each do |i|
      if proc
        item = proc.call(i)
      else
        return to_enum(:my_map) unless block_given?

        item = yield i
      end
      end_array.push item
    end
    end_array
  end

  def my_inject(acc = 0)
    each do |i|
      acc = yield(i, acc)
    end
    acc
  end
end

def multiply_els(array)
  array.my_inject(1, &:*)
end
