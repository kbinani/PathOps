import CoreGraphics


extension CGPath {
    public func subtract(path: CGPath) -> (path: CGPath, fillRule: CGPathFillRule)? {
        let skPath = SKPath(cgPath: path)
        let skSelf = SKPath(cgPath: self)
        return skSelf.subtracted(skPath).toCGPath()
    }

    public func union(with path: CGPath) -> (path: CGPath, fillRule: CGPathFillRule)? {
        let skPath = SKPath(cgPath: path)
        let skSelf = SKPath(cgPath: self)
        return skSelf.unioned(with: skPath).toCGPath()
    }

    public func simplify() -> (path: CGPath, fillRule: CGPathFillRule)? {
        let p = SKPath(cgPath: self)
        p.simplify()
        return p.toCGPath()
    }
}
