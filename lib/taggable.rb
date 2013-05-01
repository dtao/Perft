module Taggable
  def self.included(model)
    model.instance_eval do
      has n, :tags, :through => DataMapper::Resource
    end
  end

  def add_tag(tag_name)
    self.tags << Tag.first_or_create(:name => tag_name)
  end

  def add_tags(tag_names)
    tag_names.each do |tag_name|
      add_tag(tag_name)
    end
  end
end
