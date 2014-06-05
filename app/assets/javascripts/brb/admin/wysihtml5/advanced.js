/**
 * Full HTML5 compatibility rule set
 * These rules define which tags and CSS classes are supported and which tags should be specially treated.
 *
 * Examples based on this rule set:
 *
 *    <a href="http://foobar.com">foo</a>
 *    ... becomes ...
 *    <a href="http://foobar.com" target="_blank" rel="nofollow">foo</a>
 *
 *    <img align="left" src="http://foobar.com/image.png">
 *    ... becomes ...
 *    <img class="wysiwyg-float-left" src="http://foobar.com/image.png" alt="">
 *
 *    <div>foo<script>alert(document.cookie)</script></div>
 *    ... becomes ...
 *    <div>foo</div>
 *
 *    <marquee>foo</marquee>
 *    ... becomes ...
 *    <span>foo</span>
 *
 *    foo <br clear="both"> bar
 *    ... becomes ...
 *    foo <br class="wysiwyg-clear-both"> bar
 *
 *    <div>hello <iframe src="http://google.com"></iframe></div>
 *    ... becomes ...
 *    <div>hello </div>
 *
 *    <center>hello</center>
 *    ... becomes ...
 *    <div class="wysiwyg-text-align-center">hello</div>
 */
var wysihtml5ParserRules = {
  /**
   * CSS Class white-list
   * Following CSS classes won't be removed when parsed by the wysihtml5 HTML parser
   */
  "classes": {
    "wysiwyg-clear-both": 1,
    "wysiwyg-clear-left": 1,
    "wysiwyg-clear-right": 1,
    "wysiwyg-color-aqua": 1,
    "wysiwyg-color-black": 1,
    "wysiwyg-color-blue": 1,
    "wysiwyg-color-fuchsia": 1,
    "wysiwyg-color-gray": 1,
    "wysiwyg-color-green": 1,
    "wysiwyg-color-lime": 1,
    "wysiwyg-color-maroon": 1,
    "wysiwyg-color-navy": 1,
    "wysiwyg-color-olive": 1,
    "wysiwyg-color-purple": 1,
    "wysiwyg-color-red": 1,
    "wysiwyg-color-silver": 1,
    "wysiwyg-color-teal": 1,
    "wysiwyg-color-white": 1,
    "wysiwyg-color-yellow": 1,
    "wysiwyg-float-left": 1,
    "wysiwyg-float-right": 1,
    "wysiwyg-font-size-large": 1,
    "wysiwyg-font-size-larger": 1,
    "wysiwyg-font-size-medium": 1,
    "wysiwyg-font-size-small": 1,
    "wysiwyg-font-size-smaller": 1,
    "wysiwyg-font-size-x-large": 1,
    "wysiwyg-font-size-x-small": 1,
    "wysiwyg-font-size-xx-large": 1,
    "wysiwyg-font-size-xx-small": 1,
    "wysiwyg-text-align-center": 1,
    "wysiwyg-text-align-justify": 1,
    "wysiwyg-text-align-left": 1,
    "wysiwyg-text-align-right": 1
  },
  /**
   * Tag list
   *
   * The following options are available:
   *
   *    - add_class:        converts and deletes the given HTML4 attribute (align, clear, ...) via the given method to a css class
   *                        The following methods are implemented in wysihtml5.dom.parse:
   *                          - align_text:  converts align attribute values (right/left/center/justify) to their corresponding css class "wysiwyg-text-align-*")
   *                            <p align="center">foo</p> ... becomes ... <p> class="wysiwyg-text-align-center">foo</p>
   *                          - clear_br:    converts clear attribute values left/right/all/both to their corresponding css class "wysiwyg-clear-*"
   *                            <br clear="all"> ... becomes ... <br class="wysiwyg-clear-both">
   *                          - align_img:    converts align attribute values (right/left) on <img> to their corresponding css class "wysiwyg-float-*"
   *
   *    - remove:             removes the element and its content
   *
   *    - rename_tag:         renames the element to the given tag
   *
   *    - set_class:          adds the given class to the element (note: make sure that the class is in the "classes" white list above)
   *
   *    - set_attributes:     sets/overrides the given attributes
   *
   *    - check_attributes:   checks the given HTML attribute via the given method
   *                            - url:            allows only valid urls (starting with http:// or https://)
   *                            - src:            allows something like "/foobar.jpg", "http://google.com", ...
   *                            - href:           allows something like "mailto:bert@foo.com", "http://google.com", "/foobar.jpg"
   *                            - alt:            strips unwanted characters. if the attribute is not set, then it gets set (to ensure valid and compatible HTML)
   *                            - numbers:  ensures that the attribute only contains numeric characters
   */
  "tags": {
    "div": { "rename_tag": "p" },

    "a": {
      "check_attributes": {
        "href": "url" // if you compiled master manually then change this from 'url' to 'href'
      },
      "set_attributes": {
        "rel": "nofollow",
        "target": "_blank"
      }
    },

    "p":      {},
    "i":      {},
    "em":     {},
    "b":      {},
    "strong": {},
    "sup":    {},
    "br":     {},
    "ol":     {},
    "ul":     {},
    "li":     {},
    "span":   {},

    "h1":         { "rename_tag": "span" },
    "h2":         { "rename_tag": "span" },
    "h3":         { "rename_tag": "span" },
    "h6":         { "rename_tag": "span" },
    "h4":         { "rename_tag": "span" },
    "h5":         { "rename_tag": "span" },
    "multicol":   { "rename_tag": "span" },
    "figure":     { "rename_tag": "span" },
    "figcaption": { "rename_tag": "span" },
    "footer":     { "rename_tag": "span" },
    "address":    { "rename_tag": "span" },
    "nav":        { "rename_tag": "span" },
    "dd":         { "rename_tag": "span" },
    "fieldset":   { "rename_tag": "span" },
    "aside":      { "rename_tag": "span" },
    "section":    { "rename_tag": "span" },
    "body":       { "rename_tag": "span" },
    "html":       { "rename_tag": "span" },
    "blockquote": { "rename_tag": "span" },
    "hgroup":     { "rename_tag": "span" },
    "dl":         { "rename_tag": "span" },
    "listing":    { "rename_tag": "span" },
    "pre":        { "rename_tag": "span" },
    "center":     { "rename_tag": "span" },
    "article":    { "rename_tag": "span" },
    "header":     { "rename_tag": "span" },
    "details":    { "rename_tag": "span" },
    "rt":         { "rename_tag": "span" },
    "xmp":        { "rename_tag": "span" },
    "small":      { "rename_tag": "span" },
    "time":       { "rename_tag": "span" },
    "bdi":        { "rename_tag": "span" },
    "progress":   { "rename_tag": "span" },
    "dfn":        { "rename_tag": "span" },
    "rb":         { "rename_tag": "span" },
    "abbr":       { "rename_tag": "span" },
    "option":     { "rename_tag": "span" },
    "select":     { "rename_tag": "span" },
    "big":        { "rename_tag": "span" },
    "mark":       { "rename_tag": "span" },
    "caption":    { "rename_tag": "span" },
    "rp":         { "rename_tag": "span" },
    "nobr":       { "rename_tag": "span" },
    "summary":    { "rename_tag": "span" },
    "var":        { "rename_tag": "span" },
    "meter":      { "rename_tag": "span" },
    "textarea":   { "rename_tag": "span" },
    "font":       { "rename_tag": "span" },
    "tt":         { "rename_tag": "span" },
    "blink":      { "rename_tag": "span" },
    "plaintext":  { "rename_tag": "span" },
    "legend":     { "rename_tag": "span" },
    "label":      { "rename_tag": "span" },
    "kbd":        { "rename_tag": "span" },
    "dt":         { "rename_tag": "span" },
    "datalist":   { "rename_tag": "span" },
    "samp":       { "rename_tag": "span" },
    "bdo":        { "rename_tag": "span" },
    "ruby":       { "rename_tag": "span" },
    "ins":        { "rename_tag": "span" },
    "sub":        { "rename_tag": "span" },
    "optgroup":   { "rename_tag": "span" },
    
    "menu":     { "remove": 1 },
    "u":        { "remove": 1 },
    "table":    { "remove": 1 },
    "thead":    { "remove": 1 },
    "tbody":    { "remove": 1 },
    "th":       { "remove": 1 },
    "tr":       { "remove": 1 },
    "td":       { "remove": 1 },
    "strike":   { "remove": 1 },
    "form":     { "remove": 1 },
    "code":     { "remove": 1 },
    "acronym":  { "remove": 1 },
    "title":    { "remove": 1 },
    "area":     { "remove": 1 },
    "dir":      { "remove": 1 },
    "command":  { "remove": 1 },
    "iframe":   { "remove": 1 },
    "img":      { "remove": 1 },
    "noframes": { "remove": 1 },
    "applet":   { "remove": 1 },
    "spacer":   { "remove": 1 },
    "source":   { "remove": 1 },
    "frame":    { "remove": 1 },
    "del":      { "remove": 1 },
    "embed":    { "remove": 1 },
    "style":    { "remove": 1 },
    "device":   { "remove": 1 },
    "noembed":  { "remove": 1 },
    "xml":      { "remove": 1 },
    "param":    { "remove": 1 },
    "hr":       { "remove": 1 },
    "nextid":   { "remove": 1 },
    "audio":    { "remove": 1 },
    "col":      { "remove": 1 },
    "cite":     { "remove": 1 },
    "link":     { "remove": 1 },
    "script":   { "remove": 1 },
    "colgroup": { "remove": 1 },
    "comment":  { "remove": 1 },
    "frameset": { "remove": 1 },
    "tfoot":    { "remove": 1 },
    "base":     { "remove": 1 },
    "video":    { "remove": 1 },
    "canvas":   { "remove": 1 },
    "output":   { "remove": 1 },
    "marquee":  { "remove": 1 },
    "bgsound":  { "remove": 1 },
    "basefont": { "remove": 1 },
    "head":     { "remove": 1 },
    "s":        { "remove": 1 },
    "object":   { "remove": 1 },
    "track":    { "remove": 1 },
    "wbr":      { "remove": 1 },
    "button":   { "remove": 1 },
    "noscript": { "remove": 1 },
    "svg":      { "remove": 1 },
    "input":    { "remove": 1 },
    "keygen":   { "remove": 1 },
    "meta":     { "remove": 1 },
    "map":      { "remove": 1 },
    "isindex":  { "remove": 1 },
    "q":        { "remove": 1 }
  }
};