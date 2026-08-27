extension Text.Line {

    public struct Number: Sendable, Hashable {

        public let underlying: UInt

        @inlinable
        public init(_ value: UInt) {
            self.underlying = value
        }
    }
}

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
