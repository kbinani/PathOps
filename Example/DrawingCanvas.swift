@IBDesignable
class DrawingCanvas : UIView {
    private var size: CGSize = .zero
    private var strokes: [CatmulRomStroke] = []
    private var working: CatmulRomStroke? = nil

    var width: CGFloat = 40
    var color = UIColor.black
    var strokeAlpha: CGFloat = 1

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }

        ctx.saveGState()
        defer {
            ctx.restoreGState()
        }

        var strokes = self.strokes
        if let w = self.working {
            strokes.append(w)
        }

        strokes.enumerated().filter({ $0.element.alpha > 0 }).forEach({ (it) in
            let clearPath = CGMutablePath()
            strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                clearPath.addPath(c.path)
            })
            ctx.saveGState()
            defer {
                ctx.restoreGState()
            }
            let p = it.element.path.subtract(path: clearPath)
            ctx.setFillColor(it.element.color.cgColor)
            ctx.addPath(p)
            ctx.fillPath()
        })
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
        let stroke = CatmulRomStroke(width: self.width, color: self.color, alpha: self.strokeAlpha)
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
