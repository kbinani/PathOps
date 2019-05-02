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


extension SKPath {
    var fillRule: CGPathFillRule? {
        switch __fillRule() {
        case 1:
            return .winding
        case 2:
            return .evenOdd
        default:
            return nil
        }
    }

    func toCGPath() -> (path: CGPath, fillRule: CGPathFillRule)? {
        guard let fillRule = self.fillRule else {
            return nil
        }
        let p = self.__toCGPath().takeRetainedValue()
        return (path: p, fillRule: fillRule)
    }
}
