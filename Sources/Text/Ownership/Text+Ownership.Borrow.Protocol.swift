#if Ownership
public import Byte
public import Ownership

extension Text: Ownership.Borrow.`Protocol` {

    public typealias Borrowed = Swift.Span<Byte>
}
#endif
