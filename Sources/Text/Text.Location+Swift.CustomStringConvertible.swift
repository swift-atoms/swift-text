public import Cardinal
public import Tagged

extension Text.Location: Swift.CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(line):\(column)"
    }
}
