#if Casing
extension Text {
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

    public static func sentencecased<S: StringProtocol>(_ text: S) -> String {
        guard let first = text.first else { return "" }
        return String(first).uppercased() + text.dropFirst().lowercased()
    }
}
#endif
