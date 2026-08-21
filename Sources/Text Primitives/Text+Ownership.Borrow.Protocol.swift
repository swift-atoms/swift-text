public import Byte_Primitives
public import Ownership_Borrow_Primitives

extension Text: Ownership.Borrow.`Protocol` {

    public typealias Borrowed = Swift.Span<Byte>
}
