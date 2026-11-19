import Foundation
import cmark_gfm
import cmark_gfm_extensions

/// Renders GitHub Flavored Markdown into a self-contained HTML document.
public enum MarkdownRenderer {
    private static let extensionNames = ["table", "strikethrough", "autolink", "tagfilter", "tasklist"]

    // Raw HTML is allowed (READMEs lean on <img>, <details>, <p align>), but the
    // tagfilter extension neuters <script>, <iframe>, <style> and friends, as on GitHub.
    private static let options = CMARK_OPT_UNSAFE | CMARK_OPT_FOOTNOTES | CMARK_OPT_VALIDATE_UTF8

    /// Decodes file contents as UTF-8, falling back to Latin-1 so a preview always appears.
    public static func decode(_ data: Data) -> String {
        String(data: data, encoding: .utf8) ?? String(data: data, encoding: .isoLatin1) ?? ""
    }

    /// A complete HTML page, styled for light and dark appearance.
    public static func renderDocument(_ markdown: String, title: String) -> String {
        """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <meta name="color-scheme" content="light dark">
        <title>\(escapeHTML(title))</title>
        <style>\(Stylesheet.css)</style>
        </head>
        <body>
        <article class="markdown-body">
        \(renderBody(markdown))
        </article>
        </body>
        </html>
        """
    }

    /// Just the rendered HTML fragment for the Markdown, without a page wrapper.
    public static func renderBody(_ markdown: String) -> String {
        let (frontMatter, content) = splitFrontMatter(markdown)
        var html = ""
        if let frontMatter {
            html += "<pre class=\"front-matter\"><code>\(escapeHTML(frontMatter))</code></pre>\n"
        }
        html += renderGFM(content)
        return html
    }

    private static func renderGFM(_ markdown: String) -> String {
        cmark_gfm_core_extensions_ensure_registered()

        guard let parser = cmark_parser_new(options) else { return "" }
        defer { cmark_parser_free(parser) }

        for name in extensionNames {
            if let ext = cmark_find_syntax_extension(name) {
                cmark_parser_attach_syntax_extension(parser, ext)
            }
        }

        cmark_parser_feed(parser, markdown, markdown.utf8.count)
        guard let document = cmark_parser_finish(parser) else { return "" }
        defer { cmark_node_free(document) }

        guard let rendered = cmark_render_html(document, options, cmark_parser_get_syntax_extensions(parser)) else {
            return ""
        }
        defer { free(rendered) }
        return String(cString: rendered)
    }

    /// Splits off a leading YAML front matter block (`---` … `---`), which would
    /// otherwise render as a stray horizontal rule and a setext heading.
    static func splitFrontMatter(_ markdown: String) -> (frontMatter: String?, content: String) {
        let lines = markdown.split(separator: "\n", omittingEmptySubsequences: false)
        guard lines.first?.trimmingCharacters(in: .whitespacesAndNewlines) == "---" else {
            return (nil, markdown)
        }
        guard let end = lines.dropFirst().firstIndex(where: {
            let line = $0.trimmingCharacters(in: .whitespacesAndNewlines)
            return line == "---" || line == "..."
        }) else {
            return (nil, markdown)
        }
        let frontMatter = lines[1..<end].map { $0.trimmingCharacters(in: .newlines) }.joined(separator: "\n")
        let content = lines[(end + 1)...].joined(separator: "\n")
        return (frontMatter, content)
    }

    static func escapeHTML(_ string: String) -> String {
        var escaped = ""
        escaped.reserveCapacity(string.utf8.count)
        for character in string {
            switch character {
            case "&": escaped += "&amp;"
            case "<": escaped += "&lt;"
            case ">": escaped += "&gt;"
            case "\"": escaped += "&quot;"
            default: escaped.append(character)
            }
        }
        return escaped
    }
}
