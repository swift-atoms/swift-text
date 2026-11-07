public import Cardinal
public import Tagged
public import Difference
public import Ordinal

public enum Text {}

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

extension Text {

    public typealias Count = Tagged<Text, Cardinal>
}

extension Text {

    public typealias Offset = Tagged<Text, Difference>
}

extension Text {

    public typealias Position = Tagged<Text, Ordinal>
}
