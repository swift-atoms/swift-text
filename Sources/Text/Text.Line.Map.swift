public import Affine
public import Cardinal
public import Ordinal
public import Tagged

extension Text.Line {

    public struct Map: Sendable {

        @usableFromInline
        internal let lineStarts: [Text.Position]

        @inlinable
        public init(lineStarts: [Text.Position]) {
            self.lineStarts = lineStarts
        }
    }
}

extension Text.Line.Map {

    @inlinable
    public var lineCount: Int {
        lineStarts.count
    }
}

extension Text.Line.Map {

    @inlinable
    public func line(containing offset: Text.Position) -> Text.Line.Number {

        var low = 0
        var high = lineStarts.count
        while low < high {
            let mid = low + (high - low) / 2
            if lineStarts[mid].underlying <= offset.underlying {
                low = mid + 1
            } else {
                high = mid
            }
        }

        return Text.Line.Number(UInt(low))
    }

    @inlinable
    public func column(for offset: Text.Position) -> Text.Line.Column {
        let lineNumber = line(containing: offset)
        let lineIndex = Int(lineNumber.underlying) - 1
        let lineStart = lineStarts[lineIndex]

        let displacement: Text.Offset = try! offset - lineStart

        return Text.Line.Column(_unchecked: Cardinal(UInt(displacement.vector.rawValue + 1)))
    }

    @inlinable
    public func location(for offset: Text.Position) -> Text.Location {
        let lineNumber = line(containing: offset)
        let lineIndex = Int(lineNumber.underlying) - 1
        let lineStart = lineStarts[lineIndex]

        let displacement: Text.Offset = try! offset - lineStart

        let column = Text.Line.Column(_unchecked: Cardinal(UInt(displacement.vector.rawValue + 1)))
        return Text.Location(line: lineNumber, column: column)
    }

    @inlinable
    public func offset(forLine line: Text.Line.Number) -> Text.Position? {
        let index = Int(line.underlying) - 1
        guard index >= 0, index < lineStarts.count else { return nil }
        return lineStarts[index]
    }
}
