Perft::App.helpers do
  def text_filter(placeholder, target, filter_target)
    text_field_tag(nil, {
      :class => "text-filter",
      :placeholder => placeholder,
      :"data-filter" => target,
      :"data-filter-by" => filter_target
    })
  end
end
