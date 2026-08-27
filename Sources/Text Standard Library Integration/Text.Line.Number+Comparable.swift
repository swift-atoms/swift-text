public import Text

extension Text.Line.Number: Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.underlying < rhs.underlying
    }
}
