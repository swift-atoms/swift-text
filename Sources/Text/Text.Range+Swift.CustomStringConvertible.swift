import Difference
public import Ordinal
public import Tagged

extension Text.Range: Swift.CustomStringConvertible {

    @inlinable
    public var description: Swift.String {
        "\(start)..<\(end)"
    }
}
