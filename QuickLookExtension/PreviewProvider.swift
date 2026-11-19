import Foundation
import MarkdownRenderer
import QuickLookUI
import UniformTypeIdentifiers

/// Data-based Quick Look preview: renders the Markdown file to HTML and hands it
/// to Quick Look, which displays it in its own (JavaScript-free) web view.
final class PreviewProvider: QLPreviewProvider, QLPreviewingController {
    func providePreview(for request: QLFilePreviewRequest) async throws -> QLPreviewReply {
        let fileURL = request.fileURL
        let markdown = MarkdownRenderer.decode(try Data(contentsOf: fileURL))
        let html = MarkdownRenderer.renderDocument(markdown, title: fileURL.lastPathComponent)

        return QLPreviewReply(dataOfContentType: .html, contentSize: CGSize(width: 900, height: 1100)) { reply in
            reply.stringEncoding = .utf8
            reply.title = fileURL.lastPathComponent
            return Data(html.utf8)
        }
    }
}
