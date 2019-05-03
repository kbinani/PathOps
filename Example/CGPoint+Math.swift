extension CGPoint {
    static func cross(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        return p1.x * p2.y - p1.y * p2.x
    }

    static func - (_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
        return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
    }

    static func + (_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
        return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
    }

    static func * (_ p: CGPoint, _ v: CGFloat) -> CGPoint {
        return CGPoint(x: p.x * v, y: p.y * v)
    }
}
