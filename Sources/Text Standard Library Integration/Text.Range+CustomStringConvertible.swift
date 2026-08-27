public import Ordinal
public import Tagged
public import Text

extension Text.Range: CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(start.underlying.rawValue)..<\(end.underlying.rawValue)"
    }
}
