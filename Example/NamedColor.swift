struct NamedColor : CustomStringConvertible {
    let name: String
    let color: UIColor

    var description: String {
        return name
    }
}
