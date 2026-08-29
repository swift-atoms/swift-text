public import Carrier
public import Carrier_Protocol

extension Text.Line.Number: Carrier.`Protocol` {

    public typealias Underlying = UInt

}
