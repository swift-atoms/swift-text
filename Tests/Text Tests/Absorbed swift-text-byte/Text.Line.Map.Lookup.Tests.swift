#if Byte
import Testing
import Text

@Suite
struct `Scanned text line maps reject every out of range line number` {
    @Test(arguments: [UInt.zero, 3, UInt(Int.max), UInt(Int.max) + 1, UInt.max])
    func `Invalid line numbers have no byte position`(_ line: UInt) {
        let map = Text.Line.Map(scanning: [Byte(bitPattern: 0x0A)])
        #expect(map.offset(forLine: Text.Line.Number(line)) == nil)
        #expect(map.offset(forLine: 1) == .zero)
        #expect(map.offset(forLine: 2) == Text.Position(1))
    }
}
#endif
