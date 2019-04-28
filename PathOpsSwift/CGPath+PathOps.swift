import CoreGraphics
import PathOps


extension CGPath {
    public func subtract(path: CGPath) -> CGPath {
        let skPath = SKPath(cgPath: path)
        let skSelf = SKPath(cgPath: self)
        return skSelf.subtracted(skPath).toCGPath().takeRetainedValue()
    }

    public func union(with path: CGPath) -> CGPath {
        let skPath = SKPath(cgPath: path)
        let skSelf = SKPath(cgPath: self)
        return skSelf.union(with: skPath).toCGPath().takeRetainedValue()
    }
}
