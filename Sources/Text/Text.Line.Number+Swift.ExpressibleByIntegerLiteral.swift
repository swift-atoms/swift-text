extension Text.Line.Number: Swift.ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}
