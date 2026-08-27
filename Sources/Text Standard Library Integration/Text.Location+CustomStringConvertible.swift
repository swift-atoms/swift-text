public import Text

extension Text.Location: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(line):\(column)"
    }
}
