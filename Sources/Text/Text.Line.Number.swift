extension Text.Line {

    public struct Number: Sendable, Hashable, Comparable {

        public let underlying: UInt

        @inlinable
        public init(_ value: UInt) {
            self.underlying = value
        }
    }
}

#if !hasFeature(Embedded)
    extension Text.Line.Number: Codable {}
#endif

extension Text.Line.Number {

    @inlinable
    public init?(exactly value: Int) {
        guard value >= 0 else { return nil }
        self.init(UInt(value))
    }

    @inlinable
    public init(_ value: Int) throws(Self.Error) {
        guard value >= 0 else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }
}

extension Text.Line.Number: ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}

extension Text.Line.Number {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.underlying < rhs.underlying
    }
}

extension Text.Line.Number: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(underlying)"
    }
}
