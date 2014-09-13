define [], ->


  # Underscore stub for template rendering.
  # see: http://underscorejs.org


  escapeMap =
    '&': '&amp;'
    '<': '&lt;'
    '>': '&gt;'
    '"': '&quot;'
    "'": '&#x27;'
    '`': '&#x60;'
  source = '(?:' + Object.keys(escapeMap).join('|') + ')'
  testRegexp = RegExp(source)
  replaceRegexp = RegExp(source, 'g')
  escaper = (match) -> escapeMap[match]


  window._ =
    escape: (string) ->
      if testRegexp.test(string)
        string.replace(replaceRegexp, escaper)
      else
        string
