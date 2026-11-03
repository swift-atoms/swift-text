# swift-text

Use this package when a lexer, parser or diagnostic needs to name places in source text by byte offset and report them as human-readable `line:column` locations. Start from `Text.Position` and `Text.Range` for spans, then turn positions into `Text.Location` values with `Text.Line.Map` when the whole content is at hand, or with `Text.Location.Tracker` while a scanner moves forward and reports each newline itself. For a null-terminated platform string handed to or from a C API, use the sibling swift-string instead; for Unicode text you compare, search or edit, use `Swift.String`.

## Laws

- Every position, offset, count and column counts bytes, not characters: in UTF-8 text a scalar of n bytes advances the column by n. Positions start at zero; the lines and columns that `Text.Line.Map` and `Text.Location.Tracker` report start at one.
- `Text.Range` is half-open: it contains its start, excludes its end, and is empty when the two are equal. Construction traps when the end precedes the start or when start plus count passes the greatest representable position; a range ending exactly at that position is allowed.
- `Text.Location` orders by line first and by column only within the same line.
- `Text.Line.Map(validatingLineStarts:)` returns nil unless the starts are non-empty, begin at zero and strictly increase. The map stores only those starts; every lookup is a binary search over them, and nothing else is cached.
- `Text.Line.Map(scanning:)` ends a line at each LF, each CR, and each CR LF pair (one line, not two); the next line starts at the byte after the terminator. No other byte sequence, including U+2028, ends a line. Empty content has one line, and a trailing terminator begins an empty final line.
- `Text.Line.Map.offset(forLine:)` returns nil for line 0 and for every line past the last.
- `Text.Location.Tracker` sees no bytes: the caller decides what a newline is and passes the position of its final byte (the LF of a CR LF) to `newline(at:)`, which starts the next line one byte later. `location(at:)` does not move the tracker, so queries may repeat or go backward within the current line, but a position before the current line start traps. `newline(at:)` traps when the next line number or line start is not representable, and `location(at:)` traps when the column is not.
