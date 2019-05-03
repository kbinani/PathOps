@IBDesignable
class DrawingCanvas : UIView {
    private var size: CGSize = .zero
    private var strokes: [CatmulRomStroke] = []
    private var working: CatmulRomStroke? = nil

    var width: CGFloat = 40
    var color: NamedColor = .black
    var strokeAlpha: CGFloat = 1

    enum Mode : CaseIterable {
        case reference
        case fill
        case frame
    }

    var mode: Mode = .fill {
        didSet {
            guard mode != oldValue else {
                return
            }
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }

        var strokes = self.strokes
        if let w = self.working {
            strokes.append(w)
        }

        ctx.saveGState()
        defer {
            ctx.restoreGState()
            ctx.resetClip()
        }

        switch mode {
        case .reference:
            let boundingBox = strokes.reduce(into: rect) { (last, it) in
                return last.union(it.path.boundingBox)
            }

            var stateCount: Int = 0
            strokes.filter({ $0.alpha <= 0 }).forEach { (it) in
                ctx.saveGState()
                stateCount += 1
                it.eachPathSegment({ (c) in
                    ctx.addRect(boundingBox)
                    ctx.addPath(c)
                    ctx.clip(using: .evenOdd)
                })
            }
            strokes.forEach { (it) in
                if it.alpha > 0 {
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }
                    ctx.setStrokeColor(it.color.cgColor)
                    ctx.setLineWidth(it.width)
                    ctx.addPath(it.hairlinePath)
                    ctx.setLineCap(.round)
                    ctx.setLineJoin(.round)
                    ctx.strokePath()
                } else {
                    ctx.restoreGState()
                    stateCount -= 1
                }
            }
            assert(stateCount == 0)
        case .fill:
            strokes.enumerated().filter({ $0.element.alpha > 0 }).forEach({ (it) in
                var p = SKPath(cgPath: it.element.path)
                strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                    p.subtract(SKPath(cgPath: c.path))
                })

                guard let converted = p.toCGPath() else {
                    return
                }

                ctx.saveGState()
                defer {
                    ctx.restoreGState()
                }

                ctx.setFillColor(it.element.color.cgColor)
                ctx.addPath(converted.path)
                ctx.fillPath(using: converted.fillRule)
            })
        case .frame:
            strokes.enumerated().filter({ $0.element.alpha > 0 }).forEach({ (it) in
                var p = SKPath(cgPath: it.element.path)
                strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                    p.subtract(SKPath(cgPath: c.path))
                })

                guard let converted = p.toCGPath() else {
                    return
                }

                ctx.saveGState()
                defer {
                    ctx.restoreGState()
                }

                ctx.setLineWidth(1 / UIScreen.main.scale)
                ctx.setStrokeColor(it.element.color.cgColor)
                ctx.addPath(converted.path)
                ctx.strokePath()
            })
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size = self.bounds.size
        guard size != self.size else {
            return
        }
        self.size = size
        self.setNeedsDisplay()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let first = touches.first else {
            return
        }
        let stroke = CatmulRomStroke(width: self.width, color: self.color.color, alpha: self.strokeAlpha)
        stroke.push(first.location(in: self))

        self.working = stroke
        self.setNeedsDisplay()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let first = touches.first else {
            return
        }
        let point = first.location(in: self)
        self.working?.push(point)
        self.setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let working = self.working else {
            return
        }
        self.strokes.append(working)
        self.working = nil
        self.setNeedsDisplay()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.working = nil
        self.setNeedsDisplay()
    }

    func clear() {
        strokes.removeAll()
        working = nil
        setNeedsDisplay()
    }
}
