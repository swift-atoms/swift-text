extension Text.Line.Number {

    public enum Error: Swift.Error, Hashable, Sendable {

        case negativeSource(Int)
    }
}
