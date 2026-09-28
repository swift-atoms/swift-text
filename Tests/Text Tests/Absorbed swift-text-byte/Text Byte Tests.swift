#if Byte
import Byte
import Ordinal
import Testing
import Text
import Tagged

@Suite
struct `Byte scanning preserves text line starts across newline encodings` {

    private func lineMap(for string: Swift.String) -> Text.Line.Map {
        Text.Line.Map(scanning: string.utf8.map(Byte.init(bitPattern:)))
    }

    private func offset(
        in map: Text.Line.Map,
        forLine line: UInt
    ) -> UInt? {
        map.offset(forLine: Text.Line.Number(line))?.underlying.rawValue
    }

    @Test
    func `Empty content has one line beginning at zero`() {
        let map = lineMap(for: "")
        #expect(map.lineCount == 1)
        #expect(offset(in: map, forLine: 1) == 0)
    }

    @Test
    func `Content without a newline has one line beginning at zero`() {
        let map = lineMap(for: "hello")
        #expect(map.lineCount == 1)
        #expect(offset(in: map, forLine: 1) == 0)
    }

    @Test
    func `Each line feed begins a new line after its byte`() {

        let map = lineMap(for: "a\nb\nc")
        #expect(map.lineCount == 3)
        #expect(offset(in: map, forLine: 1) == 0)
        #expect(offset(in: map, forLine: 2) == 2)
        #expect(offset(in: map, forLine: 3) == 4)
    }

    @Test
    func `Each carriage return begins a new line after its byte`() {

        let map = lineMap(for: "a\rb\rc")
        #expect(map.lineCount == 3)
        #expect(offset(in: map, forLine: 1) == 0)
        #expect(offset(in: map, forLine: 2) == 2)
        #expect(offset(in: map, forLine: 3) == 4)
    }

    @Test
    func `Each carriage return and line feed pair begins one new line`() {

        let map = lineMap(for: "a\r\nb\r\nc")
        #expect(map.lineCount == 3)
        #expect(offset(in: map, forLine: 1) == 0)
        #expect(offset(in: map, forLine: 2) == 3)
        #expect(offset(in: map, forLine: 3) == 6)
    }

    @Test
    func `A trailing newline begins an empty final line`() {
        let map = lineMap(for: "a\n")
        #expect(map.lineCount == 2)
        #expect(offset(in: map, forLine: 2) == 2)
    }

    @Test
    func `Mixed newline encodings preserve each line start`() {

        let map = lineMap(for: "a\nb\rc\r\nd")
        #expect(map.lineCount == 4)
        #expect(offset(in: map, forLine: 1) == 0)
        #expect(offset(in: map, forLine: 2) == 2)
        #expect(offset(in: map, forLine: 3) == 4)
        #expect(offset(in: map, forLine: 4) == 7)
    }

    @Test
    func `Columns count UTF8 bytes and Unicode line separators remain within a line`() {
        let map = lineMap(for: "é\u{2028}😀\r\nz")
        #expect(map.lineCount == 2)
        #expect(offset(in: map, forLine: 2) == 11)
        #expect(map.column(for: 9) == 10)
        #expect(map.location(for: 12) == Text.Location(line: 2, column: 2))
    }
}
#endif
