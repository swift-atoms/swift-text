public import Interval

extension Text.Range {

    /// Why a range could not be built: `reversed` when the end precedes the start,
    /// `overflow` when the end is not representable.
    public typealias Error = Interval.Discrete<Text.Position>.Error
}
