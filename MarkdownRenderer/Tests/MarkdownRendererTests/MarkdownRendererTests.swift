import XCTest
@testable import MarkdownRenderer

final class MarkdownRendererTests: XCTestCase {
    func testHeadingsAndEmphasis() {
        let html = MarkdownRenderer.renderBody("# Title\n\nSome *em* and **strong**.")
        XCTAssertTrue(html.contains("<h1>Title</h1>"), html)
        XCTAssertTrue(html.contains("<em>em</em>"), html)
        XCTAssertTrue(html.contains("<strong>strong</strong>"), html)
    }

    func testGFMTable() {
        let html = MarkdownRenderer.renderBody("| a | b |\n|---|---|\n| 1 | 2 |\n")
        XCTAssertTrue(html.contains("<table>"), html)
        XCTAssertTrue(html.contains("<td>1</td>"), html)
    }

    func testGFMStrikethroughAutolinkAndTaskList() {
        let html = MarkdownRenderer.renderBody("~~gone~~ https://example.com\n\n- [x] done\n- [ ] todo\n")
        XCTAssertTrue(html.contains("<del>gone</del>"), html)
        XCTAssertTrue(html.contains("<a href=\"https://example.com\">"), html)
        XCTAssertTrue(html.contains("type=\"checkbox\""), html)
        XCTAssertTrue(html.contains("checked"), html)
    }

    func testFencedCodeKeepsLanguageClass() {
        let html = MarkdownRenderer.renderBody("```swift\nlet x = 1 < 2\n```\n")
        XCTAssertTrue(html.contains("<pre lang=\"swift\"><code>") || html.contains("class=\"language-swift\""), html)
        XCTAssertTrue(html.contains("1 &lt; 2"), html)
    }

    func testRawScriptIsFiltered() {
        let html = MarkdownRenderer.renderBody("<script>alert(1)</script>\n")
        XCTAssertFalse(html.contains("<script>"), html)
    }

    func testFrontMatterIsRenderedAsCodeBlock() {
        let html = MarkdownRenderer.renderBody("---\ntitle: Hello\n---\n\n# Body\n")
        XCTAssertTrue(html.contains("class=\"front-matter\""), html)
        XCTAssertTrue(html.contains("title: Hello"), html)
        XCTAssertTrue(html.contains("<h1>Body</h1>"), html)
        XCTAssertFalse(html.contains("<hr"), html)
    }

    func testDocumentWrapsBodyWithStylesheetAndEscapedTitle() {
        let html = MarkdownRenderer.renderDocument("Hi", title: "a<b>.md")
        XCTAssertTrue(html.hasPrefix("<!DOCTYPE html>"), html)
        XCTAssertTrue(html.contains("<title>a&lt;b&gt;.md</title>"), html)
        XCTAssertTrue(html.contains("prefers-color-scheme: dark"), html)
        XCTAssertTrue(html.contains("<p>Hi</p>"), html)
    }
}
