public import Text

extension Text.Line.Number: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(underlying)"
    }
}
