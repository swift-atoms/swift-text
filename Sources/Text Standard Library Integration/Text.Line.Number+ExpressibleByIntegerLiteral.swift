public import Text

extension Text.Line.Number: ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}
