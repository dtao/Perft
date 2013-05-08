Perft::App.helpers do
  def render_changeset(suite_run)
    return "" if suite_run.wip?
    h("#{suite_run.changeset}: #{suite_run.comment.lines.first}")
  end
end
