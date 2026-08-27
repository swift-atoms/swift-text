extension Text {

    public struct Location: Sendable, Hashable {

        public let line: Text.Line.Number

        public let column: Text.Line.Column

        @inlinable
        public init(line: Text.Line.Number, column: Text.Line.Column) {
            self.line = line
            self.column = column
        }
    }
}
