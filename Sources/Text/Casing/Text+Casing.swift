#if Casing
extension Text {
    /// Unicode default casing, with words separated by whitespace. Separators
    /// are preserved. Each word's first Character is uppercased and the rest
    /// lowercased; no locale-sensitive or punctuation-based segmentation occurs.
    public static func titlecased<S: StringProtocol>(_ text: S) -> String {
        var output = ""
        var startsWord = true
        for character in text {
            if character.isWhitespace {
                output.append(character)
                startsWord = true
            } else {
                let value = String(character)
                output += startsWord ? value.uppercased() : value.lowercased()
                startsWord = false
            }
        }
        return output
    }

    /// Uppercase the first Character and lowercase the remainder, preserving
    /// whitespace. This is a text transformation, not a numeric/format style.
    public static func sentencecased<S: StringProtocol>(_ text: S) -> String {
        guard let first = text.first else { return "" }
        return String(first).uppercased() + text.dropFirst().lowercased()
    }
}
#endif
