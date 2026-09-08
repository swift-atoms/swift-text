public import Cardinal
public import Difference
public import Ordinal
public import Tagged

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
        lineStart = try! position + Text.Offset.one
    }
}

extension Text.Location.Tracker {

    @inlinable
    public func location(at cursor: Text.Position) -> Text.Location {

        let bytes = Text.Range(start: lineStart, end: cursor).count
        let column: Text.Line.Column = bytes + Text.Count.one
        return Text.Location(line: line, column: column)
    }
}
