public import Cardinal
public import Difference
public import Ordinal
public import Tagged

extension Text.Location {

    public struct Tracker: Sendable, Equatable, Hashable {

        public var line: Text.Line.Number

        public var lineStart: Text.Position

        @inlinable
        public init() {
            self.line = 1
            self.lineStart = .zero
        }
    }
}

extension Text.Location.Tracker {

    /// Starts the next line after the newline at `position`; leaves the tracker unchanged when it throws.
    @inlinable
    public mutating func newline(at position: Text.Position) throws(Error) {
        guard line.underlying != UInt.max else { throw .lineNumberOverflow }
        let next: Text.Position
        do {
            next = try position + Text.Offset.one
        } catch {
            throw .lineStartOverflow
        }
        line = Text.Line.Number(line.underlying + 1)
        lineStart = next
    }
}

extension Text.Location.Tracker {

    @inlinable
    public func location(at cursor: Text.Position) throws(Error) -> Text.Location {
        let bytes: Text.Count
        do {
            bytes = try Text.Range(start: lineStart, end: cursor).count
        } catch {
            throw .beforeLineStart
        }
        let column: Cardinal
        do {
            column = try bytes.underlying.add.exact(.one)
        } catch {
            throw .columnOverflow
        }
        return Text.Location(line: line, column: Text.Line.Column(_unchecked: column))
    }
}
