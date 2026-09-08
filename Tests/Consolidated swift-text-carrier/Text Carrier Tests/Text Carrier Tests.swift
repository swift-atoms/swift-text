import Carrier
import Testing
import Text
import Text
import Carrier

@Suite
struct `Text Line Number Carrier Tests` {
    @Test
    func `Carrier conformance — Underlying is UInt`() {

        let number = Text.Line.Number(UInt(42))
        let carried: UInt = number.underlying
        #expect(carried == 42)
    }

    @Test
    func `Carrier conformance — generic dispatch`() {

        func extract<C: Carrier.`Protocol`<UInt>>(_ carrier: C) -> UInt {
            carrier.underlying
        }

        let number = Text.Line.Number(UInt(42))
        #expect(extract(number) == 42)
    }

    @Test
    func `Carrier conformance — validating init`() throws {

        enum Validation: Swift.Error, Equatable {
            case rejected
        }

        let valid = try Text.Line.Number(42) { (raw: borrowing UInt) throws(Validation) in
            if raw == 0 { throw .rejected }
        }
        #expect(valid.underlying == 42)

        #expect(throws: Validation.rejected) {
            try Text.Line.Number(0) { (raw: borrowing UInt) throws(Validation) in
                if raw == 0 { throw .rejected }
            }
        }
    }
}
