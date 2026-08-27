#if !hasFeature(Embedded)
    public import Cardinal
    public import Tagged
    public import Text

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
            self.init(
                line: Text.Line.Number(lineValue),
                column: Text.Line.Column(_unchecked: Cardinal(columnValue))
            )
        }

        @inlinable
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(line.underlying, forKey: .line)

            try container.encode(column.underlying.rawValue, forKey: .column)
        }
    }
#endif
