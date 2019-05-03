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

    public func toCGPath() -> (path: CGPath, fillRule: CGPathFillRule)? {
        guard let fillRule = self.fillRule else {
            return nil
        }
        let p = self.__toCGPath().takeRetainedValue()
        return (path: p, fillRule: fillRule)
    }
}