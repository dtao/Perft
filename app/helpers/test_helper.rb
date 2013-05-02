Perft::App.helpers do
  def render_changeset(suite_run)
    return "" if suite_run.wip?
    h("#{suite_run.changeset}: #{suite_run.comment}")
  end

  def render_tags(test_run)
    test_run.tags.map(&:name).join(", ")
  end
end
