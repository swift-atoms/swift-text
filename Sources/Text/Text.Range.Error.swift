public import Interval

extension Text.Range {

    public enum Error: Swift::Error, Hashable, Sendable {

        /// The end precedes the start.
        case reversed

        /// The end is not representable.
        case overflow
    }
}

extension Text.Range.Error {

    @inlinable
    init(_ error: Interval.Discrete<Text.Position>.Error) {
        switch error {
        case .reversed: self = .reversed
        case .overflow: self = .overflow
        }
    }
}
