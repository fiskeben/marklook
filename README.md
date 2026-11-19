# marklook

A macOS Quick Look extension that renders Markdown in Finder. Select a `.md` file and press <kbd>Space</kbd>.

It handles GitHub Flavored Markdown (tables, task lists, strikethrough, autolinks, footnotes) via [cmark-gfm](https://github.com/swiftlang/swift-cmark), uses GitHub-like styling that follows light/dark mode, and shows YAML front matter as a dimmed block.

## Build

Requires macOS 13+, Xcode, [XcodeGen](https://github.com/yonaskolb/XcodeGen) and an Apple Development certificate. Set `DEVELOPMENT_TEAM` in `project.yml` to your own team.

```sh
make install   # build, copy to ~/Applications, register, relaunch Finder
make test      # renderer tests
make uninstall
```

If previews don't show up, enable the extension under **System Settings → General → Login Items & Extensions → Quick Look**.

## Limitations

Quick Look renders HTML previews with JavaScript disabled, so there's no syntax highlighting or Mermaid. Relative images aren't shown because the sandboxed extension can only read the previewed file.

## License

[MIT](LICENSE)
