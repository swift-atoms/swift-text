public import Affine
public import Cardinal
public import Tagged

extension Text {

    public typealias Count = Tagged<Text, Cardinal>
}

extension Tagged where Tag == Text, Underlying == Cardinal {

    @inlinable
    public init(_ offset: Text.Offset) throws(Cardinal.Error) {
        let value = offset.underlying.rawValue
        guard value >= 0 else { throw .negativeSource(value) }
        self.init(_unchecked: Cardinal(UInt(value)))
    }

    @inlinable
    public static var one: Self {
        Self(_unchecked: Cardinal(1))
    }
}

@inlinable
public func == (lhs: Text.Count, rhs: Text.Count) -> Bool {
    lhs.underlying == rhs.underlying
}

@inlinable
public func != (lhs: Text.Count, rhs: Text.Count) -> Bool {
    !(lhs == rhs)
}

@inlinable
public func < (lhs: Text.Count, rhs: Text.Count) -> Bool {
    lhs.underlying < rhs.underlying
}

@inlinable
public func <= (lhs: Text.Count, rhs: Text.Count) -> Bool {
    lhs.underlying <= rhs.underlying
}

@inlinable
public func > (lhs: Text.Count, rhs: Text.Count) -> Bool {
    lhs.underlying > rhs.underlying
}

@inlinable
public func >= (lhs: Text.Count, rhs: Text.Count) -> Bool {
    lhs.underlying >= rhs.underlying
}
