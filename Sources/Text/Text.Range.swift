import Difference
public import Interval
public import Ordinal
public import Tagged

extension Text {

    public struct Range: Sendable, Equatable, Hashable {

        @usableFromInline
        internal let interval: Interval.Discrete<Text.Position>

        /// Throws ``Error/reversed`` when `end` precedes `start`.
        @inlinable
        public init(start: Text.Position, end: Text.Position) throws(Error) {
            do {
                self.interval = try Interval.Discrete(start: start, end: end)
            } catch {
                throw Error(error)
            }
        }

        /// Throws ``Error/overflow`` when the end `start + count` is not representable.
        @inlinable
        public init(start: Text.Position, count: Text.Count) throws(Error) {
            do {
                self.interval = try Interval.Discrete(start: start, count: count)
            } catch {
                throw Error(error)
            }
        }
    }
}

extension Text.Range {

    public enum Error: Swift::Error, Hashable, Sendable {

        /// The end precedes the start.
        case reversed

        /// The end is not representable.
        case overflow
    }
}

extension Text.Range.Error {

    @inlinable
    init(_ error: Interval.Discrete<Text.Position>.Error) {
        switch error {
        case .reversed: self = .reversed
        case .overflow: self = .overflow
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

extension Text.Range: Swift::CustomStringConvertible {

    @inlinable
    public var description: Swift::String {
        "\(start)..<\(end)"
    }
}
