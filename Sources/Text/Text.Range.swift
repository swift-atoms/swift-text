public import Interval
public import Ordinal
public import Tagged

extension Text {

    public struct Range: Sendable, Equatable, Hashable {

        @usableFromInline
        internal let interval: Interval.Discrete<Text.Position>

        @inlinable
        public init(start: Text.Position, end: Text.Position) {
            self.interval = try! Interval.Discrete(start: start, end: end)
        }

        @inlinable
        public init(start: Text.Position, count: Text.Count) {
            self.interval = try! Interval.Discrete(start: start, count: count)
        }
    }
}

extension Text.Range {

    @inlinable
    public var start: Text.Position {
        interval.start
    }

    @inlinable
    public var end: Text.Position {
        interval.end
    }

    @inlinable
    public var count: Text.Count {
        interval.count
    }

    @inlinable
    public var isEmpty: Bool {
        interval.isEmpty
    }

    @inlinable
    public func contains(_ position: Text.Position) -> Bool {
        interval.contains(position)
    }
}
