#if Ownership
    import Byte
    import Ownership
    import Testing
    import Text

    @Suite("Text × Ownership.Borrow")
    struct Text_Ownership_Tests {

        @Test
        func `Text conforms to Ownership.Borrow.Protocol`() {
            requireBorrowProtocol(Text.self)
        }

        @Test
        func `Text's borrowed representation is a read-only byte span`() {
            let bytes = [Byte(bitPattern: 0x41), Byte(bitPattern: 0x42)]
            let borrowed: Text.Borrowed = bytes.span

            #expect(borrowed.count == 2)
            #expect(borrowed[0].bitPattern == 0x41)
            #expect(borrowed[1].bitPattern == 0x42)
        }
    }

    private func requireBorrowProtocol<T: Ownership.Borrow.`Protocol`>(_: T.Type) {}
#endif
