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

#if !hasFeature(Embedded)
    extension Text.Location: Codable {
        @usableFromInline

        internal enum CodingKeys: Swift.String, CodingKey {
            case line
            case column
        }

        @inlinable
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let lineValue = try container.decode(UInt.self, forKey: .line)
            let columnValue = try container.decode(UInt.self, forKey: .column)
            self.line = Text.Line.Number(lineValue)
            self.column = Text.Line.Column(_unchecked: Cardinal(columnValue))
        }

        @inlinable
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(line.underlying, forKey: .line)

            try container.encode(column.underlying.rawValue, forKey: .column)
        }
    }
#endif

extension Text.Location: Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.line != rhs.line { return lhs.line < rhs.line }
        return lhs.column < rhs.column
    }
}

extension Text.Location: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(line):\(column)"
    }
}
