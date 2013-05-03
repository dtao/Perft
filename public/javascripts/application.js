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

  $(".text-filter").each(function() {
    var $input = $(this);
    var target = $input.attr("data-filter");
    var filterTarget = $input.attr("data-filter-by");

    $input.keyup(function() {
      var prefixes = $.trim($input.val()).split(/\s+/);
      $(target).each(function() {
        var $element = $(this);
        var matchCount = 0;
        var matchedAllPrefixes = false;
        $(filterTarget, $element).each(function() {
          for (var i = 0; i < prefixes.length; ++i) {
            if (this.textContent.indexOf(prefixes[i]) === 0) {
              ++matchCount;
            }
          }
          if (matchCount === prefixes.length) {
            matchedAllPrefixes = true;
            return false;
          }
        });
        $element[matchedAllPrefixes ? "show" : "hide"]();
      });
    });
  });

  $("textarea.code").each(function() {
    CodeMirror.fromTextArea(this, {
      mode: $(this).attr("data-mode"),
      readOnly: true,
      viewportMargin: Infinity
    });
  });

  setTimeout(function clearNotice() {
    $(".notices").empty();
  }, 3000);
});
