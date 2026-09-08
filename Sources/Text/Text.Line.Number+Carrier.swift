public import Carrier

/// Exposes a text line number's `UInt` representation through `Carrier`.
extension Text.Line.Number: Carrier.`Protocol` {

    public typealias Underlying = UInt

}
