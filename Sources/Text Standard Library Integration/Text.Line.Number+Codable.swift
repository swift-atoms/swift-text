#if !hasFeature(Embedded)
    public import Text

    extension Text.Line.Number: Codable {
        @usableFromInline

        internal enum CodingKeys: Swift.String, CodingKey {
            case underlying
        }

        @inlinable
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.init(try container.decode(UInt.self, forKey: .underlying))
        }

        @inlinable
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(underlying, forKey: .underlying)
        }
    }
#endif
