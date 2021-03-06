extension SKPath {
    public var fillRule: CGPathFillRule? {
        switch __fillRule() {
        case 1:
            return .winding
        case 2:
            return .evenOdd
        default:
            return nil
        }
    }

    public func toCGPath(with resolution: CGFloat) -> (path: CGPath, fillRule: CGPathFillRule)? {
        guard let fillRule = self.fillRule else {
            return nil
        }
        let p = self.__toCGPath(with: resolution).takeRetainedValue()
        return (path: p, fillRule: fillRule)
    }

    public func subtract(_ path: CGPath) {
        self.subtract(SKPath(cgPath: path))
    }
    
    public func union(with path: CGPath) {
        self.union(with: SKPath(cgPath: path))
    }
}
