$(document).ready(function() {
  $(".reveal-link").each(function() {
    var $link   = $(this);
    var $target = $($link.attr("href")).hide();
    $link.click(function() {
      $target.show().find("input[type='text']:first").focus();
      return false;
    });
  });

  $(".tabs a").click(function() {
    var $link = $(this);
    $("a.selected").removeClass("selected");
    $("section.displayed").removeClass("displayed");
    $link.addClass("selected");
    $($link.attr("href")).addClass("displayed");
    return false;
  });

  $("textarea.changes").each(function() {
    CodeMirror.fromTextArea(this, {
      mode: "text/x-diff",
      readOnly: true
    });
  });
});
