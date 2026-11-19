import SwiftUI

/// Host app for the Quick Look extension. Launching it once registers the
/// extension with the system; after that it never needs to run again.
@main
struct MarkdownPreviewApp: App {
    var body: some Scene {
        Window("Markdown Preview", id: "main") {
            ContentView()
        }
        .windowResizability(.contentSize)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Markdown Quick Look is installed", systemImage: "doc.richtext")
                .font(.title2.weight(.semibold))
            Text("Select a .md file in Finder and press Space to preview it.")
            Text("If previews don't appear, make sure the extension is enabled under System Settings → General → Login Items & Extensions → Quick Look.")
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                Spacer()
                Button("Open Extension Settings") {
                    if let url = URL(string: "x-apple.systempreferences:com.apple.ExtensionsPreferences") {
                        NSWorkspace.shared.open(url)
                    }
                }
                Button("Done") { NSApp.terminate(nil) }
                    .keyboardShortcut(.defaultAction)
            }
        }
        .padding(24)
        .frame(width: 460)
    }
}
