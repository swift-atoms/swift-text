public import Cardinal
public import Tagged

extension Text {

    public struct Location: Sendable, Hashable {

        public let line: Text.Line.Number

        public let column: Text.Line.Column

        @inlinable
        public init(line: Text.Line.Number, column: Text.Line.Column) {
            self.line = line
            self.column = column
        }
    }
}

extension Text.Location {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.line == rhs.line && lhs.column == rhs.column
    }

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(line.underlying)
        hasher.combine(column.underlying.rawValue)
    }
}
