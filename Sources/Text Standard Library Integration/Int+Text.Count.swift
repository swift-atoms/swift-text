public import Cardinal
public import Tagged
public import Text

extension Int {

    @inlinable
    public init(_ count: Text.Count) throws(Cardinal.Error) {
        guard count.underlying.rawValue <= UInt(Int.max) else { throw .overflow }
        self = Int(count.underlying.rawValue)
    }
}
