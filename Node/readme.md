# Node Toolbox

- Author: Chuncheng Zhang
- Date: 2021-03-15
- Version: 0.0

## Description

Build myself a node toolbox.

## Contains

### Showdown convert

Convert markdown script into html strings,
with the supports of

- Native conversion
- Katex Formula
- Code Highlight

### Require packages

The npm packages:

```powershell
# Native
npm install showdown

# Katex support
npm install showdown-katex

# Code highlight support
npm install highlightjs
```

The front end also needs the support from [https://highlightjs.org/download/](https://highlightjs.org/download/).
The website provides off-line .css files and customized highlight.js file,
where you can select your favorite languages.

## Development Diary

2020-03-15

- Establish required npm packages
- Building test environment
