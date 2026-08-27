public import Text

extension Text.Range: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(start)..<\(end)"
    }
}
