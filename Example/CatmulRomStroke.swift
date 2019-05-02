class CatmulRomStroke {
    private var points: [CGPoint] = []
    let width: CGFloat
    private let _color: UIColor
    let alpha: CGFloat

    private var _path: CGPath? = nil
    private var _hairlinePath: CGPath? = nil

    var color: UIColor {
        return _color.withAlphaComponent(alpha)
    }

    init(width: CGFloat, color: UIColor, alpha: CGFloat) {
        self.width = width
        self._color = color
        self.alpha = alpha
    }

    func push(_ point: CGPoint) {
        self.points.append(point)
        self._path = nil
        self._hairlinePath = nil
    }

    var hairlinePath: CGPath {
        if let p = self._hairlinePath {
            return p
        }
        let result = CGMutablePath()
        for idx in 0 ..< self.points.count - 1 {
            let p = self.points[idx]
            if idx == 0 {
                result.move(to: p)
            }
            if let control = CatmulRomStroke.controlPoint(points: self.points, index: idx) {
                result.addCurve(to: p, control1: control.point1, control2: control.point2)
            } else {
                result.addLine(to: p)
            }
        }
        self._hairlinePath = result
        return result
    }

    func eachPathSegment(_ callback: (_ path: CGPath) -> Void) {
        guard self.points.count >= 2 else {
            return
        }
        for idx in 1 ..< self.points.count - 1 {
            let p0 = self.points[idx - 1]
            let p1 = self.points[idx]
            let item = CGMutablePath()
            item.move(to: p0)
            if let control = CatmulRomStroke.controlPoint(points: self.points, index: idx) {
                item.addCurve(to: p1, control1: control.point1, control2: control.point2)
            } else {
                item.addLine(to: p1)
            }
            callback(item.copy(strokingWithWidth: width, lineCap: .round, lineJoin: .round, miterLimit: 0))
        }
    }

    var path: CGPath {
        if let p = self._path {
            return p
        }
        let hairlinePath = self.hairlinePath
        let p = hairlinePath.copy(strokingWithWidth: width, lineCap: .round, lineJoin: .round, miterLimit: 0).simplify()
        self._path = p
        return p
    }

    private struct BezierControl {
        let point1: CGPoint
        let point2: CGPoint
    }

    private static let catmulRomToBezierTightness: CGFloat = 0.5

    private static func controlPoint(points: [CGPoint], index: Int) -> BezierControl? {
        guard 0 <= index - 1, index < points.count else {
            return nil
        }
        let p1 = points[index - 1]
        let p2 = points[index]

        let c1: CGPoint
        let c2: CGPoint

        if 0 <= index - 2 {
            let p0 = points[index - 2]
            let v1 = p2 - p0
            let v2 = p1 - p0
            if CGFloat.almostEquals(CGPoint.cross(v1, v2), 0) {
                c1 = p1
            } else {
                c1 = (p2 - p0) * (self.catmulRomToBezierTightness / 3) + p1
            }
        } else {
            c1 = p1
        }

        if index + 1 < points.count {
            let p3 = points[index + 1]
            let v1 = p1 - p3
            let v2 = p2 - p3
            if CGFloat.almostEquals(CGPoint.cross(v1, v2), 0) {
                c2 = p2
            } else {
                c2 = (p1 - p3) * (self.catmulRomToBezierTightness / 3) + p2
            }
        } else {
            c2 = p2
        }

        return BezierControl(point1: c1, point2: c2)
    }
}
