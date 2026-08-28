public import Byte
public import Ownership_Borrow

extension Text: Ownership.Borrow.`Protocol` {

    public typealias Borrowed = Swift.Span<Byte>
}
