import Difference
import Cardinal
import Ordinal
import Tagged
import Testing
import Text_Test_Support

@Suite
struct `Text positions preserve byte offsets through arithmetic ordering and formatting` {
    @Suite struct `No text position unit cases are defined` {}
    @Suite struct `No text position boundary cases are defined` {}
    @Suite struct `No text position integration cases are defined` {}

    @Test
    func `zero is byte offset 0`() {
        let position = Text.Position.zero
        #expect(position == 0)
    }

    @Test
    func `A text position preserves its integer literal value`() {
        let position: Text.Position = 42
        #expect(position == 42)
    }

    @Test
    func `Text positions compare in byte offset order`() {
        let a: Text.Position = 10
        let b: Text.Position = 20
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == 10)
    }

    @Test
    func `subtraction returns typed offset`() throws {
        let a: Text.Position = 25
        let b: Text.Position = 10
        let offset: Text.Offset = a - b
        #expect(offset == Text.Offset(15))
    }

    @Test
    func `Adding a text offset advances a position and zero preserves it`() throws {
        let position: Text.Position = 10
        let offset = Text.Offset(5)
        #expect(try position + offset == 15)
        #expect(try position + Text.Offset.zero == position)
    }

    @Test
    func `Equal text positions share a hash and occupy one set entry`() {
        let a: Text.Position = 42
        let b: Text.Position = 42
        #expect(a.hashValue == b.hashValue)

        var set: Set<Text.Position> = [a, b]
        #expect(set.count == 1)
        let c: Text.Position = 99
        set.insert(c)
        #expect(set.count == 2)
    }

    @Test
    func `Text position descriptions contain their numeric byte offsets`() {
        let pos: Text.Position = 42
        #expect(pos.description == "42")
        #expect(Text.Position.zero.description == "0")
    }
}

@Suite
struct `Text offsets preserve signed differences through equality ordering and formatting` {
    @Suite struct `No text offset unit cases are defined` {}
    @Suite struct `No text offset boundary cases are defined` {}
    @Suite struct `No text offset integration cases are defined` {}

    @Test
    func `The zero text offset equals an offset constructed from zero`() {
        #expect(Text.Offset.zero == Text.Offset(0))
    }

    @Test
    func `Equal signed integer inputs construct equal text offsets`() {
        #expect(Text.Offset(42) == Text.Offset(42))
        #expect(Text.Offset(-5) == Text.Offset(-5))
    }

    @Test
    func `Text offsets order negative zero and positive differences`() {
        let a = Text.Offset(-1)
        let b = Text.Offset(0)
        let c = Text.Offset(1)
        #expect(a < b)
        #expect(b < c)
    }

    @Test
    func `Text offset equality distinguishes different differences`() {
        let a = Text.Offset(10)
        let b = Text.Offset(10)
        let c = Text.Offset(11)
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `Equal text offsets occupy one set entry`() {
        let a = Text.Offset(5)
        let b = Text.Offset(5)
        let set: Set<Text.Offset> = [a, b]
        #expect(set.count == 1)
    }

    @Test
    func `A text offset exposes its stored difference`() {
        let offset = Text.Offset(42)

        #expect(offset.difference == Difference(42))
    }

    @Test
    func `Text offset descriptions preserve signed numeric values`() {
        #expect(Text.Offset(15).description == "15")
        #expect(Text.Offset(-3).description == "-3")
    }
}

@Suite
struct `Text counts preserve magnitudes through comparison conversion and formatting` {
    @Suite struct `No text count unit cases are defined` {}
    @Suite struct `No text count boundary cases are defined` {}
    @Suite struct `No text count integration cases are defined` {}

    @Test
    func `A text count preserves its integer literal value`() {
        let count: Text.Count = 42
        #expect(count == 42)
    }

    @Test
    func `A text offset magnitude supplies the corresponding text count`() {
        let offset = Text.Offset(15)
        let count: Text.Count = offset.magnitude.map(\.value)
        #expect(count == 15)
    }

    @Test
    func `Text counts compare in magnitude order`() {
        let a: Text.Count = 5
        let b: Text.Count = 10
        #expect(a < b)
        #expect(b > a)
    }

    @Test
    func `Equal numeric values construct equal text counts`() {
        let a: Text.Count = 10
        let b: Text.Count = 10
        #expect(a == b)
    }

    @Test
    func `Converting a text count to Int preserves its value`() throws {
        let count: Text.Count = 42
        #expect(try Int(count) == 42)
    }

    @Test
    func `A text count description contains its numeric value`() {
        let count: Text.Count = 15
        #expect(count.description == "15")
    }
}

@Suite
struct `Text ranges preserve bounds counts and half open membership` {
    @Suite struct `No text range unit cases are defined` {}
    @Suite struct `No text range boundary cases are defined` {}
    @Suite struct `No text range integration cases are defined` {}

    @Test
    func `Text range construction preserves explicit start and end positions`() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.start == 10)
        #expect(range.end == 20)
    }

    @Test
    func `Text range construction adds the count to its start position`() {
        let range = Text.Range(start: 10, count: 15)
        #expect(range.start == 10)
        #expect(range.end == 25)
    }

    @Test
    func `count returns Text.Count`() {
        let range = Text.Range(start: 10, end: 25)
        #expect(range.count == 15)
    }

    @Test
    func `A text range with equal bounds is empty and has zero count`() {
        let range = Text.Range(start: 10, end: 10)
        #expect(range.isEmpty)
        #expect(range.count == 0)
    }

    @Test
    func `non-empty range is not empty`() {
        let range = Text.Range(start: 0, end: 1)
        #expect(!range.isEmpty)
    }

    @Test
    func `Text range membership includes the start and excludes the end`() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.contains(10))
        #expect(range.contains(15))
        #expect(range.contains(19))
        #expect(!range.contains(20))
        #expect(!range.contains(9))
        #expect(!range.contains(25))
    }

    @Test
    func `Text range equality distinguishes different bounds`() {
        let a = Text.Range(start: 10, end: 20)
        let b = Text.Range(start: 10, end: 20)
        let c = Text.Range(start: 10, end: 21)
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `Equal text ranges occupy one set entry and distinct ranges add another`() {
        let a = Text.Range(start: 10, end: 20)
        let b = Text.Range(start: 10, end: 20)
        var set: Set<Text.Range> = [a, b]
        #expect(set.count == 1)
        set.insert(Text.Range(start: 0, end: 5))
        #expect(set.count == 2)
    }

    @Test
    func `Text range descriptions use half open interval notation`() {
        let range = Text.Range(start: 10, end: 20)
        #expect(range.description == "10..<20")
    }

    @Test
    func `A text range with zero bounds is empty and preserves both bounds`() {
        let range = Text.Range(start: .zero, end: .zero)
        #expect(range.isEmpty)
        #expect(range.start == .zero)
        #expect(range.end == .zero)
    }
}

@Suite
struct `Text line numbers validate signed inputs and preserve numeric values` {
    @Suite struct `No text line number unit cases are defined` {}
    @Suite struct `No text line number boundary cases are defined` {}
    @Suite struct `No text line number integration cases are defined` {}

    @Test
    func `Text line number construction preserves an unsigned integer`() {
        let number = Text.Line.Number(1)
        #expect(number.underlying == 1)
    }

    @Test
    func `A text line number preserves its integer literal value`() {
        let number: Text.Line.Number = 42
        #expect(number.underlying == 42)
    }

    @Test
    func `Text line number construction preserves a positive signed integer`() throws {
        let value: Int = 5
        let number = try Text.Line.Number(value)
        #expect(number.underlying == 5)
    }

    @Test
    func `Text line number construction accepts signed zero`() throws {
        let value: Int = 0
        let number = try Text.Line.Number(value)
        #expect(number.underlying == 0)
    }

    @Test
    func `init from Int — negative throws`() {
        let value: Int = -1
        #expect(throws: Text.Line.Number.Error.negativeSource(-1)) {
            try Text.Line.Number(value)
        }
    }

    @Test
    func `Exact text line number construction preserves a positive signed integer`() {
        let value: Int = 5
        let number = Text.Line.Number(exactly: value)
        #expect(number?.underlying == 5)
    }

    @Test
    func `init exactly — negative returns nil`() {
        let value: Int = -1
        #expect(Text.Line.Number(exactly: value) == nil)
    }

    @Test
    func `Text line numbers compare in numeric order`() {
        let a: Text.Line.Number = 1
        let b: Text.Line.Number = 10
        #expect(a < b)
        #expect(b > a)
        #expect(a <= a)
    }

    @Test
    func `Text line number equality distinguishes different numeric values`() {
        let a: Text.Line.Number = 5
        let b: Text.Line.Number = 5
        let c: Text.Line.Number = 6
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `Equal text line numbers occupy one set entry and distinct numbers add another`() {
        let a: Text.Line.Number = 5
        let b: Text.Line.Number = 5
        var set: Set<Text.Line.Number> = [a, b]
        #expect(set.count == 1)
        set.insert(10)
        #expect(set.count == 2)
    }

    @Test
    func `A text line number description contains its numeric value`() {
        let number: Text.Line.Number = 42
        #expect(number.description == "42")
    }

}

@Suite
struct `Text locations preserve coordinates and compare lines before columns` {
    @Suite struct `No text location unit cases are defined` {}
    @Suite struct `No text location boundary cases are defined` {}
    @Suite struct `No text location integration cases are defined` {}

    @Test
    func `Text location construction preserves its line and column`() {
        let location = Text.Location(
            line: 5,
            column: Text.Line.Column(_unchecked: Cardinal(10))
        )
        #expect(location.line == 5)
        #expect(location.column == 10)
    }

    @Test
    func `description is line:column`() {
        let location = Text.Location(
            line: 42,
            column: Text.Line.Column(_unchecked: Cardinal(17))
        )
        #expect(location.description == "42:17")
    }

    @Test
    func `Text locations compare different lines before considering columns`() {
        let a = Text.Location(
            line: 1,
            column: Text.Line.Column(_unchecked: Cardinal(99))
        )
        let b = Text.Location(
            line: 2,
            column: Text.Line.Column(_unchecked: .one)
        )
        #expect(a < b)
    }

    @Test
    func `Text locations on the same line compare their columns`() {
        let a = Text.Location(
            line: 5,
            column: Text.Line.Column(_unchecked: .one)
        )
        let b = Text.Location(
            line: 5,
            column: Text.Line.Column(_unchecked: Cardinal(10))
        )
        #expect(a < b)
    }

    @Test
    func `Equal text locations do not order before each other`() {
        let a = Text.Location(
            line: 5,
            column: Text.Line.Column(_unchecked: Cardinal(10))
        )
        let b = Text.Location(
            line: 5,
            column: Text.Line.Column(_unchecked: Cardinal(10))
        )
        #expect(a == b)
        #expect(!(a < b))
    }

    @Test
    func `Equal text locations occupy one set entry`() {
        let a = Text.Location(
            line: 1,
            column: Text.Line.Column(_unchecked: .one)
        )
        let b = Text.Location(
            line: 1,
            column: Text.Line.Column(_unchecked: .one)
        )
        let set: Set<Text.Location> = [a, b]
        #expect(set.count == 1)
    }

}

@Suite
struct `Text line maps validate starts and map positions to lines and columns` {
    @Suite struct `No text line map unit cases are defined` {}
    @Suite struct `No text line map boundary cases are defined` {}
    @Suite struct `No text line map integration cases are defined` {}

    private func lineMap(_ lineStarts: [Text.Position]) -> Text.Line.Map {
        Text.Line.Map(validatingLineStarts: lineStarts)!
    }

    @Test
    func `validated line starts preserve typed positions`() throws {
        let map = try #require(Text.Line.Map(validatingLineStarts: [.zero, 4, 9]))

        #expect(map.lineCount == 3)
        #expect(map.offset(forLine: 1) == Text.Position.zero)
        #expect(map.offset(forLine: 2) == Text.Position(4))
        #expect(map.offset(forLine: 3) == Text.Position(9))
    }

    @Test(
        arguments: [
            [] as [Text.Position],
            [1],
            [0, 4, 4],
            [0, 5, 3],
        ]
    )
    func `invalid line starts are rejected`(_ lineStarts: [Text.Position]) {
        #expect(Text.Line.Map(validatingLineStarts: lineStarts) == nil)
    }

    @Test
    func `Text line maps count columns from one within each line`() {

        let map = lineMap([0, 4])

        #expect(map.column(for: 0) == 1)

        #expect(map.column(for: 2) == 3)

        #expect(map.column(for: 4) == 1)

        #expect(map.column(for: 6) == 3)
    }

    @Test
    func `Text line maps compose the corresponding line column and description`() {

        let map = lineMap([0, 4])
        let location = map.location(for: 6)
        #expect(location.line == 2)
        #expect(location.column == 3)
        #expect(location.description == "2:3")
    }

    @Test
    func `Text line maps return the start position for a valid line`() {

        let map = lineMap([0, 4])
        #expect(map.offset(forLine: 1) == 0)
        #expect(map.offset(forLine: 2) == 4)
    }

    @Test
    func `Text line maps return nil for lines outside the stored range`() {
        let map = lineMap([.zero])
        #expect(map.offset(forLine: 0) == nil)
        #expect(map.offset(forLine: 2) == nil)
    }

}
