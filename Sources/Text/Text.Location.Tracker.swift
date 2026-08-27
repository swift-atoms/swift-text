public import Cardinal
public import Ordinal
public import Tagged

extension Text.Location {

    public struct Tracker: Sendable, Equatable, Hashable {

        public var line: Text.Line.Number

        public var lineStart: Text.Position

        @inlinable
        public init() {
            self.line = Text.Line.Number(UInt(1))
            self.lineStart = Text.Position(_unchecked: .zero)
        }
    }
}

extension Text.Location.Tracker {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.line == rhs.line && lhs.lineStart == rhs.lineStart
    }

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(line.underlying)
        hasher.combine(lineStart.underlying.rawValue)
    }
}

extension Text.Location.Tracker {

    @inlinable
    public mutating func newline(at position: Text.Position) {
        line = Text.Line.Number(line.underlying + 1)
        lineStart = try! position + Text.Offset(1)
    }
}

extension Text.Location.Tracker {

    @inlinable
    public func location(at cursor: Text.Position) -> Text.Location {

        let offset: Text.Offset = try! cursor - lineStart
        let bytes = try! Text.Count(offset)
        let column = Text.Line.Column(
            _unchecked: Cardinal(bytes.underlying.rawValue + 1)
        )
        return Text.Location(line: line, column: column)
    }
}
