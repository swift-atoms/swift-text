#if Ownership
import Byte
import Ownership
import Testing
import Text

@Suite("Text × Ownership.Borrow")
struct Text_Ownership_Tests {

    @Test("Text conforms to Ownership.Borrow.Protocol")
    func borrowProtocolConformance() {
        requireBorrowProtocol(Text.self)
    }

    @Test("Text's borrowed representation is a read-only byte span")
    func borrowedRepresentation() {
        let bytes = [Byte(bitPattern: 0x41), Byte(bitPattern: 0x42)]
        let borrowed: Text.Borrowed = bytes.span

        #expect(borrowed.count == 2)
        #expect(borrowed[0].bitPattern == 0x41)
        #expect(borrowed[1].bitPattern == 0x42)
    }
}

private func requireBorrowProtocol<T: Ownership.Borrow.`Protocol`>(_: T.Type) {}
#endif
