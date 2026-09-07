public import Cardinal
public import Tagged

extension Text.Location: Swift.Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.line != rhs.line { return lhs.line < rhs.line }
        return lhs.column < rhs.column
    }
}
