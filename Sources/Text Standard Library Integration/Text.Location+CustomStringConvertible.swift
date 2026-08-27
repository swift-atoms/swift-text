public import Cardinal
public import Tagged
public import Text

extension Text.Location: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(line.underlying):\(column.underlying.rawValue)"
    }
}
