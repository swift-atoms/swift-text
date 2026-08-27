public import Affine
public import Ordinal
public import Tagged

extension Text {

    public typealias Position = Tagged<Text, Ordinal>
}

extension Tagged where Tag == Text, Underlying == Ordinal {

    @inlinable
    public static var zero: Self {
        Self(_unchecked: .zero)
    }
}

@inlinable
public func == (lhs: Text.Position, rhs: Text.Position) -> Bool {
    lhs.underlying == rhs.underlying
}

@inlinable
public func != (lhs: Text.Position, rhs: Text.Position) -> Bool {
    !(lhs == rhs)
}

@inlinable
public func < (lhs: Text.Position, rhs: Text.Position) -> Bool {
    lhs.underlying < rhs.underlying
}

@inlinable
public func <= (lhs: Text.Position, rhs: Text.Position) -> Bool {
    lhs.underlying <= rhs.underlying
}

@inlinable
public func > (lhs: Text.Position, rhs: Text.Position) -> Bool {
    lhs.underlying > rhs.underlying
}

@inlinable
public func >= (lhs: Text.Position, rhs: Text.Position) -> Bool {
    lhs.underlying >= rhs.underlying
}

@inlinable
public func - (lhs: Text.Position, rhs: Text.Position) throws(Ordinal.Error) -> Text.Offset {
    let lhsValue = lhs.underlying.rawValue
    let rhsValue = rhs.underlying.rawValue

    if lhsValue >= rhsValue {
        let magnitude = lhsValue - rhsValue
        guard magnitude <= UInt(Int.max) else { throw .overflow }
        return Text.Offset(_unchecked: Affine.Discrete.Vector(Int(magnitude)))
    }

    let magnitude = rhsValue - lhsValue
    guard magnitude <= UInt(Int.max) + 1 else { throw .overflow }
    if magnitude == UInt(Int.max) + 1 {
        return Text.Offset(_unchecked: Affine.Discrete.Vector(Int.min))
    }
    return Text.Offset(_unchecked: Affine.Discrete.Vector(-Int(magnitude)))
}

@inlinable
public func + (lhs: Text.Position, rhs: Text.Offset) throws(Ordinal.Error) -> Text.Position {
    let displacement = rhs.underlying.rawValue
    if displacement >= 0 {
        let (result, overflow) = lhs.underlying.rawValue.addingReportingOverflow(
            UInt(displacement)
        )
        guard !overflow else { throw .overflow }
        return Text.Position(_unchecked: Ordinal(result))
    }

    let magnitude = displacement.magnitude
    guard lhs.underlying.rawValue >= magnitude else { throw .underflow }
    return Text.Position(_unchecked: Ordinal(lhs.underlying.rawValue - magnitude))
}
