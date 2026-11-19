enum Stylesheet {
    // GitHub-like typography. Quick Look previews have JavaScript disabled, so
    // everything here is plain CSS, with dark mode driven by prefers-color-scheme.
    static let css = """
    :root {
      --fg: #1f2328; --muted: #59636e; --bg: #ffffff; --border: #d1d9e0;
      --subtle-bg: #f6f8fa; --code-bg: rgba(129,139,152,0.12); --link: #0969da;
      --quote: #59636e; --mark: #fff8c5;
    }
    @media (prefers-color-scheme: dark) {
      :root {
        --fg: #f0f6fc; --muted: #9198a1; --bg: #0d1117; --border: #3d444d;
        --subtle-bg: #151b23; --code-bg: rgba(101,108,118,0.2); --link: #4493f8;
        --quote: #9198a1; --mark: rgba(187,128,9,0.4);
      }
    }
    * { box-sizing: border-box; }
    html { background: var(--bg); }
    body {
      margin: 0; color: var(--fg); background: var(--bg);
      font: 16px/1.6 -apple-system, BlinkMacSystemFont, "Helvetica Neue", sans-serif;
      -webkit-font-smoothing: antialiased; word-wrap: break-word;
    }
    .markdown-body { max-width: 900px; margin: 0 auto; padding: 32px 40px 48px; }
    .markdown-body > :first-child { margin-top: 0 !important; }
    h1, h2, h3, h4, h5, h6 { margin: 24px 0 16px; font-weight: 600; line-height: 1.25; }
    h1 { font-size: 2em; padding-bottom: .3em; border-bottom: 1px solid var(--border); }
    h2 { font-size: 1.5em; padding-bottom: .3em; border-bottom: 1px solid var(--border); }
    h3 { font-size: 1.25em; } h4 { font-size: 1em; }
    h5 { font-size: .875em; } h6 { font-size: .85em; color: var(--muted); }
    p, blockquote, ul, ol, dl, table, pre, details { margin: 0 0 16px; }
    a { color: var(--link); text-decoration: none; }
    a:hover { text-decoration: underline; }
    hr { height: 4px; margin: 24px 0; padding: 0; border: 0; background: var(--border); border-radius: 2px; }
    ul, ol { padding-left: 2em; }
    li + li { margin-top: .25em; }
    li > ul, li > ol { margin: .25em 0 0; }
    li:has(> input[type=checkbox]) { list-style: none; }
    li > input[type=checkbox] { margin: 0 .3em .2em -1.4em; vertical-align: middle; }
    blockquote { padding: 0 1em; color: var(--quote); border-left: .25em solid var(--border); }
    blockquote > :last-child { margin-bottom: 0; }
    code, kbd, pre, samp {
      font-family: ui-monospace, "SF Mono", SFMono-Regular, Menlo, monospace; font-size: 85%;
    }
    code { padding: .2em .4em; background: var(--code-bg); border-radius: 6px; }
    pre {
      padding: 16px; overflow: auto; line-height: 1.45;
      background: var(--subtle-bg); border-radius: 6px;
    }
    pre code { padding: 0; background: transparent; font-size: 100%; white-space: pre; }
    pre.front-matter { border: 1px dashed var(--border); color: var(--muted); }
    kbd {
      padding: 3px 5px; border: 1px solid var(--border); border-bottom-width: 2px;
      border-radius: 6px; background: var(--subtle-bg);
    }
    mark { background: var(--mark); color: inherit; }
    table { display: block; width: max-content; max-width: 100%; overflow: auto; border-collapse: collapse; }
    th, td { padding: 6px 13px; border: 1px solid var(--border); }
    th { font-weight: 600; }
    tr:nth-child(2n) { background: var(--subtle-bg); }
    img { max-width: 100%; }
    details > summary { cursor: pointer; }
    .footnotes { font-size: 85%; color: var(--muted); border-top: 1px solid var(--border); padding-top: 8px; }
    """
}
