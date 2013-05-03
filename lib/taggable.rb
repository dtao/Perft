module Taggable
  def self.included(model)
    model.instance_eval do
      has n, :tags, :through => DataMapper::Resource
    end
  end

  def tags_key
    self.tag_names.sort.join(", ")
  end

  def tag_names
    self.tags.map(&:name)
  end

  def add_tag(tag_name, safe_after=true)
    self.tags << Tag.first_or_create(:name => tag_name)
    save if safe_after
  end

  def add_tags(tag_names)
    tag_names.each do |tag_name|
      add_tag(tag_name, false)
    end
    save
  end
end
