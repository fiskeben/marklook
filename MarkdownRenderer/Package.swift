// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MarkdownRenderer",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "MarkdownRenderer", targets: ["MarkdownRenderer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-cmark", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "MarkdownRenderer",
            dependencies: [
                .product(name: "cmark-gfm", package: "swift-cmark"),
                .product(name: "cmark-gfm-extensions", package: "swift-cmark"),
            ]
        ),
        .testTarget(name: "MarkdownRendererTests", dependencies: ["MarkdownRenderer"]),
    ]
)
