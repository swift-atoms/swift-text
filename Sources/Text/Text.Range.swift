public import Cardinal
public import Ordinal
public import Tagged

extension Text {

    public struct Range: Sendable, Equatable, Hashable {

        public let start: Text.Position

        public let end: Text.Position

        @inlinable
        public init(start: Text.Position, end: Text.Position) {
            self.start = start
            self.end = end
        }

        @inlinable
        public init(start: Text.Position, count: Text.Count) {
            self.start = start
            let (end, overflow) = start.underlying.rawValue.addingReportingOverflow(
                count.underlying.rawValue
            )
            precondition(!overflow, "Text range end overflow")
            self.end = Text.Position(_unchecked: Ordinal(end))
        }
    }
}

extension Text.Range {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.start == rhs.start && lhs.end == rhs.end
    }

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(start.underlying.rawValue)
        hasher.combine(end.underlying.rawValue)
    }
}

extension Text.Range {

    @inlinable
    public var count: Text.Count {
        precondition(end >= start, "Text range end precedes start")
        return Text.Count(
            _unchecked: Cardinal(end.underlying.rawValue - start.underlying.rawValue)
        )
    }

    @inlinable
    public var isEmpty: Bool {
        start.underlying == end.underlying
    }

    @inlinable
    public func contains(_ position: Text.Position) -> Bool {
        let value = position.underlying.rawValue
        return start.underlying.rawValue <= value && value < end.underlying.rawValue
    }
}
