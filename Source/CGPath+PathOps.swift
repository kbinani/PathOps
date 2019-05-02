import CoreGraphics


extension CGPath {
    public func subtract(path: CGPath) -> CGPath {
        let skPath = SKPath(cgPath: path)
        let skSelf = SKPath(cgPath: self)
        return skSelf.subtracted(skPath).toCGPath().takeRetainedValue()
    }

    public func union(with path: CGPath) -> CGPath {
        let skPath = SKPath(cgPath: path)
        let skSelf = SKPath(cgPath: self)
        return skSelf.unioned(with: skPath).toCGPath().takeRetainedValue()
    }

    public func simplify() -> CGPath {
        let p = SKPath(cgPath: self)
        p.simplify()
        return p.toCGPath().takeRetainedValue()
    }
}
