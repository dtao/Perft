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
end
