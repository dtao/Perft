module Enumerable
  def group_consecutive(&selector)
    groups = []
    self.each do |e|
      key = selector.call(e)
      if groups.empty? || groups.last[0] != key
        groups << [key, [e]]
      else
        groups.last[1] << e
      end
    end
    groups
  end

  def map_to_hash(&key_selector)
    hash = {}
    self.each do |e|
      hash[key_selector.call(e)] = e
    end
    hash
  end

  def top(count, &selector)
    selector = lambda { |x| x } if !block_given?

    top_values = []
    self.each do |*e|
      value = selector.call(e)
      if top_values.length < count || value > selector.call(top_values.first)
        index = top_values.bsearch_lower_boundary { |x| selector.call(x) <=> value }
        top_values.insert(index, e)
        top_values.shift() if top_values.length > count
      end
    end
    top_values
  end
end
