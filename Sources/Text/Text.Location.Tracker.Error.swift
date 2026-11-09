extension Text.Location.Tracker {

    public enum Error: Swift::Error, Hashable, Sendable {

        /// The queried position precedes the current line's start.
        case beforeLineStart

        /// The next line number is not representable.
        case lineNumberOverflow

        /// The position after the newline is not representable.
        case lineStartOverflow

        /// The one-based column is not representable.
        case columnOverflow
    }
}
