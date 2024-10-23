# frozen_string_literal: true

class Array
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_size
    i = 0

    return i if self == []

    loop { self[i] ? i += 1 : break }
    i
  end

  def my_reverse
    return self if length < 2

    i = length - 1
    new_arr = []
    while i >= 0
      new_arr << self[i]
      i -= 1
    end
    new_arr
  end
end

class String
  def my_reverse
    return self if length < 2

    i = length - 1
    new_arr = []
    while i >= 0
      new_arr << self[i]
      i -= 1
    end
    new_arr.join('')
  end
end
