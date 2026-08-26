extension Text.Location {

    public struct Tracker: Sendable, Equatable, Hashable {

        public var line: Text.Line.Number

        public var lineStart: Text.Position

        @inlinable
        public init() {
            self.line = 1
            self.lineStart = .zero
        }
    }
}

extension Text.Location.Tracker {

    @inlinable
    public mutating func newline(at position: Text.Position) {
        line = Text.Line.Number(line.underlying + 1)
        lineStart = position + .one
    }
}

extension Text.Location.Tracker {

    @inlinable
    public func location(at cursor: Text.Position) -> Text.Location {

        let offset: Text.Offset = try! cursor - lineStart
        let bytes: Text.Count = offset.magnitude
        let column: Text.Line.Column = bytes + .one
        return Text.Location(line: line, column: column)
    }
}
