---
title: Quick Look sample
tags: [markdown, test]
---

# Markdown Preview

A **Quick Look** extension that renders *GitHub Flavored Markdown*, with `inline code`, ~~strikethrough~~ and autolinks like https://commonmark.org.

## Lists

- [x] Tables
- [x] Task lists
- [ ] World domination

1. First
2. Second
   - Nested

> Blockquotes look like this.
> They can span lines.

## Code

```swift
let greeting = "Hello, <world>"
print(greeting)
```

## Table

| Feature       | Supported | Notes              |
|---------------|:---------:|--------------------|
| Tables        | ✅        | GFM extension      |
| Footnotes     | ✅        | Like this one[^1]  |
| Dark mode     | ✅        | Follows the system |

<details>
<summary>Raw HTML works too</summary>

Hidden content. <kbd>⌘</kbd> + <kbd>Space</kbd>

</details>

<script>alert("this is filtered")</script>

[^1]: Footnotes render at the bottom.
