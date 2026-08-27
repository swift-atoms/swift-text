public import Affine
public import Cardinal
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

            self.end = try! start + Text.Offset(count)
        }
    }
}

extension Text.Range {

    @inlinable
    public var count: Text.Count {

        try! start.distance.forward(to: end)
    }

    @inlinable
    public var isEmpty: Bool {
        start == end
    }

    @inlinable
    public func contains(_ position: Text.Position) -> Bool {
        start <= position && position < end
    }
}
