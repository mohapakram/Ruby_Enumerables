# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/ModuleLength
#  rubocop:disable Metrics/MethodLength,Style/CaseEquality
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

  def my_all?(arg = nil)
    result = true
    if block_given?
      each do |item|
        result = false unless yield item
      end
    elsif arg
      if arg.is_a?(Regexp)
        each do |item|
          result = false unless arg.match(item)
        end
      else
        each do |item|
          result = false unless arg === item
        end
      end
    else
      each do |item|
        result = false unless item
      end
    end
    result
  end

  def my_any?(arg = nil)
    result = false
    if block_given?
      each do |i|
        result = true if yield i

        next
      end
    elsif arg
      if arg.is_a?(Regexp)
        each do |item|
          result = true if arg.match(item)
        end
      else
        each do |item|
          result = true if arg === item
        end
      end
    else
      each do |i|
        result = true if i

        next
      end
    end
    result
  end

  def my_none?(arg = nil)
    result = true
    if block_given?
      each do |item|
        result = false if yield item
      end
    elsif arg
      if arg.is_a?(Regexp)
        each do |item|
          result = false if arg.match(item)
        end
      else
        each do |item|
          result = false if arg == item
        end
      end
    else
      each do |item|
        result = false if item
      end
    end
    result
  end

  def my_count(number = nil)
    input = Array(self)

    count = 0
    if number
      each do |i|
        count += 1 if i == number
      end
    else
      return input.length unless block_given?

      each do |i|
        count += 1 if yield i
      end
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

  def my_inject(*args)
    acc = 0
    operation = nil
    if args.empty?
      return raise LocalJumpError, 'no block given' unless block_given?

      acc = Array(self)[0]
      each do |i|
        acc = yield(i, acc)
      end
    elsif args.length == 1
      if args[0].is_a? Symbol
        operation = args[0]

        each do |i|
          acc = i.send(operation, acc)
        end
      elsif args[0].is_a? Numeric
        return raise TypeError, "#{args[0]} is not a symbol nor a string" unless block_given?

        acc = args[0]

        each do |i|
          acc = yield(i, acc)
        end

      end

    elsif args.length == 2
      return raise TypeError unless args[0].is_a? Numeric

      acc = args[0]
      operation = args[1] if args[1].is_a? Symbol

      each do |i|
        if block_given?
          acc = yield(i, acc)
        elsif !operation.nil?
          acc = i.send(operation, acc)
        else
          return raise TypeError
        end
      end
    end
    acc
  end
end

def multiply_els(array)
  array.my_inject(1, &:*)
end

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength,Style/CaseEquality

[2, 3, 3].my_inject(1)
