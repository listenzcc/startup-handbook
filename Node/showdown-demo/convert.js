// System packages
const fs = require("fs");

// Showndown packages
const highlightjs = require("highlightjs");
const katex = require("katex");
const showdown = require("showdown");
const showdownKatex = require("showdown-katex");

// Setup showdown
showdown.extension("codehighlight", function() {
    function htmlunencode(text) {
        return text
            .replace(/&amp;/g, "&")
            .replace(/&lt;/g, "<")
            .replace(/&gt;/g, ">");
    }
    return [{
        type: "output",
        filter: function(text, converter, options) {
            // use new showdown's regexp engine to conditionally parse codeblocks
            var left = "<pre><code\\b[^>]*>",
                right = "</code></pre>",
                flags = "g",
                replacement = function(wholeMatch, match, left, right) {
                    // unescape match to prevent double escaping
                    match = htmlunencode(match);
                    return left + highlightjs.highlightAuto(match).value + right;
                };
            return showdown.helper.replaceRecursiveRegExp(
                text,
                replacement,
                left,
                right,
                flags
            );
        },
    }, ];
});

// Generate converter
const converter = new showdown.Converter({
    extensions: [
        "codehighlight",
        showdownKatex({
            displayMode: true,
            throwOnError: false, // allows katex to fail silently
            errorColor: "#ff0000",
            delimiters: [
                { left: "$$", right: "$$", display: false },
                { left: "$", right: "$", display: false },
                { left: "~", right: "~", display: false, asciimath: true },
            ],
        }),
    ],
});
showdown.setFlavor("github");

// Read example.md
const mdStr = fs.readFileSync("example.md").toString();

// Read template.html
// It contains {{body}} part to be filled
var template = fs.readFileSync("template.html").toString();

// Convert mdStr into its html
const renderStr1 = converter.makeHtml(mdStr);

// Convert native str into its html
const renderStr2 = katex.renderToString(
    "x=\\frac{ -b + \\sqrt{ b^2-4ac } } {2a}"
);

// Fill the html into the {{body}} part of the template
var html = template.replace("{{body}}", renderStr1 + renderStr2);

// Write the generated html into example.html
fs.writeFile("example.html", html, function(err) {
    console.log(html);
});