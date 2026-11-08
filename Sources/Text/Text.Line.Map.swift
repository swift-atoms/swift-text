public import Cardinal
public import Difference
public import Ordinal
public import Tagged

extension Text.Line {

    public struct Map: Sendable {

        @usableFromInline
        internal let lineStarts: [Text.Position]
    }
}

extension Text.Line.Map {

    @inlinable
    public init?(validatingLineStarts lineStarts: [Text.Position]) {
        guard let first = lineStarts.first, first == .zero else { return nil }

        var previous = first
        for start in lineStarts.dropFirst() {
            guard previous < start else { return nil }
            previous = start
        }

        self.lineStarts = lineStarts
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
            if lineStarts[mid] <= offset {
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

        let displacement: Text.Offset = offset - lineStart

        return Text.Line.Column(
            _unchecked: Cardinal(displacement.difference.magnitude.value.rawValue + 1)
        )
    }

    @inlinable
    public func location(for offset: Text.Position) -> Text.Location {
        let lineNumber = line(containing: offset)
        let lineIndex = Int(lineNumber.underlying) - 1
        let lineStart = lineStarts[lineIndex]

        let displacement: Text.Offset = offset - lineStart

        let column = Text.Line.Column(
            _unchecked: Cardinal(displacement.difference.magnitude.value.rawValue + 1)
        )
        return Text.Location(line: lineNumber, column: column)
    }

    @inlinable
    public func offset(forLine line: Text.Line.Number) -> Text.Position? {
        guard line.underlying > 0, line.underlying <= UInt(lineStarts.count) else {
            return nil
        }
        let index = Int(line.underlying - 1)
        return lineStarts[index]
    }
}

#if Byte
    public import Byte
    public import Ordinal
    public import Tagged

    extension Text.Line.Map {

        @inlinable
        public init(scanning content: [Byte]) {
            var starts: [Text.Position] = [.zero]
            var index = 0
            let count = content.count
            while index < count {
                let byte = content[index]
                if byte.bitPattern == 0x0A {

                    starts.append(Text.Position(_unchecked: Ordinal(UInt(index + 1))))
                } else if byte.bitPattern == 0x0D {

                    if content.indices.contains(index + 1)
                        && content[index + 1].bitPattern == 0x0A
                    {

                        index += 1
                    }
                    starts.append(Text.Position(_unchecked: Ordinal(UInt(index + 1))))
                }
                index += 1
            }
            guard let map = Self(validatingLineStarts: starts) else {
                preconditionFailure("The byte scanner produced invalid line starts")
            }
            self = map
        }
    }
#endif
