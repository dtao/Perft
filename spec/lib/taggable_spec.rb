require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe Taggable do
  let(:taggable) {
    test_run = PerformanceTestRun.create({
      :test_id  => 1,
      :suite_run_id => 1,
      :elapsed_seconds => 10,
    })
  }

  describe "add_tags" do
    it "creates any tags that don't already exist" do
      taggable.add_tags(["foo", "bar"])
      Tag.first(:name => "foo").should_not be_nil
      Tag.first(:name => "bar").should_not be_nil
    end

    it "actually associates the created tags with the taggable record" do
      taggable.add_tags(["foo", "bar"])
      taggable.reload
      taggable.tag_names.should =~ ["foo", "bar"]
    end
  end
end
