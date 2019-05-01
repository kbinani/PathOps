extension CGFloat {
    static func almostEquals(_ v1: CGFloat, _ v2: CGFloat) -> Bool {
        return abs(v1 - v2) < CGFloat.leastNormalMagnitude
    }
}
