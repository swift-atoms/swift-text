public import Affine
public import Tagged

extension Text {

    public typealias Offset = Tagged<Text, Affine.Discrete.Vector>
}

extension Tagged where Tag == Text, Underlying == Affine.Discrete.Vector {

    @inlinable
    public init(_ value: Int) {
        self.init(_unchecked: Affine.Discrete.Vector(value))
    }

    @inlinable
    public static var zero: Self {
        Self(_unchecked: .zero)
    }

    @inlinable
    public var vector: Affine.Discrete.Vector {
        underlying
    }
}
