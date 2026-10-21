public import Interval
public import Ordinal
public import Tagged

extension Text {

    public struct Range: Sendable, Equatable, Hashable {

        @usableFromInline
        internal let interval: Interval.Discrete<Text.Position>

        @inlinable
        public init(start: Text.Position, end: Text.Position) {
            do {
                self.interval = try Interval.Discrete(start: start, end: end)
            } catch {
                preconditionFailure("Text.Range requires start <= end: \(error)")
            }
        }

        @inlinable
        public init(start: Text.Position, count: Text.Count) {
            do {
                self.interval = try Interval.Discrete(start: start, count: count)
            } catch {
                preconditionFailure("Text.Range requires a representable end: \(error)")
            }
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
