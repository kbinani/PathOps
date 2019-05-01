struct NamedColor : CustomStringConvertible, Equatable {
    let name: String
    let color: UIColor

    var description: String {
        return name
    }

    static func == (_ a: NamedColor, _ b: NamedColor) -> Bool {
        return a.color == b.color
    }

    static let black = NamedColor(name: "black", color: UIColor.black)
    static let red = NamedColor(name: "red", color: UIColor.red)
    static let blue = NamedColor(name: "blue", color: UIColor.blue)
    static let orange = NamedColor(name: "orange", color: UIColor.orange)
    static let green = NamedColor(name: "green", color: UIColor.green)
    static let gray = NamedColor(name: "gray", color: UIColor.gray)
    static let darkGray = NamedColor(name: "darkGray", color: UIColor.darkGray)
}
