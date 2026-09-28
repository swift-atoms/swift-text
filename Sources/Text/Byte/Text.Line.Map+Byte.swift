#if Byte
public import Byte
public import Ordinal
public import Tagged

extension Text.Line.Map {

    @inlinable
    public init(scanning content: [Byte]) {
        var starts: [Text.Position] = [.zero]
        var index = 0
        let count = content.count
        while index < count {
            let byte = content[index]
            if byte.bitPattern == 0x0A {

                starts.append(Text.Position(_unchecked: Ordinal(UInt(index + 1))))
            } else if byte.bitPattern == 0x0D {

                if content.indices.contains(index + 1)
                    && content[index + 1].bitPattern == 0x0A
                {

                    index += 1
                }
                starts.append(Text.Position(_unchecked: Ordinal(UInt(index + 1))))
            }
            index += 1
        }
        guard let map = Self(validatingLineStarts: starts) else {
            preconditionFailure("The byte scanner produced invalid line starts")
        }
        self = map
    }
}
#endif
