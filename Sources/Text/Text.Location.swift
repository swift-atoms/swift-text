import Cardinal
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

extension Text.Location: Swift::Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.line != rhs.line { return lhs.line < rhs.line }
        return lhs.column < rhs.column
    }
}

extension Text.Location: Swift::CustomStringConvertible {

    @inlinable
    public var description: Swift::String {
        "\(line):\(column)"
    }
}
