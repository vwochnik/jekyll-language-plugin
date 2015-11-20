(function(wnd, $) {
  var languageRegex = /^([^-]+)/ig;

  $(function() {
    if ($("#site-languages-json").length > 0) {
      var languages = JSON.parse($("#site-languages-json").html() || "{}");
      var navlang = navigator.language || navigator.userLanguage;

      if ((match = languageRegex.exec(navlang))) {
        var language = match[1];

        if (languages.hasOwnProperty(language)) {
          var path = languages[language];
          setTimeout(function() {
            wnd.location.replace(path);
          }, 5000);
        }
      }
    }
  });
})(window, jQuery);
