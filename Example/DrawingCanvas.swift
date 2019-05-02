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
                let m: Int = 6
                if m == 9 {
                    let p = SKPath()
                    it.element.eachPathSegment({ (o) in
                        var sub = SKPath(cgPath: o)
                        strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                            sub.subtract(SKPath(cgPath: c.path))
                        })
                        p.union(with: sub)
                    })
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p.toCGPath().takeRetainedValue())
                    ctx.fillPath()
                } else if m == 8 {
                    let p = SKPath(cgPath: it.element.path)
                    strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                        c.eachPathSegment({ (cp) in
                            p.subtract(SKPath(cgPath: cp))
                        })
                    })
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }
                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p.toCGPath().takeRetainedValue())
                    ctx.fillPath()
                } else if m == 7 {
                    var p = SKPath(cgPath: it.element.hairlinePath).copyStroking(withWidth: it.element.width, lineCap: .round, lineJoin: .round, miterLimit: 0, resolutionScale: 1e-10)
                    strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                        let cp = SKPath(cgPath: c.hairlinePath).copyStroking(withWidth: c.width, lineCap: .round, lineJoin: .round, miterLimit: 0, resolutionScale: 1e-10)
                        p.subtract(cp)
                    })
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p.toCGPath().takeRetainedValue())
                    ctx.fillPath()
                } else if m == 6 {
                    //ok?
                    var p = SKPath(cgPath: it.element.path)
                    strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                        p.subtract(SKPath(cgPath: c.path))
                    })

                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p.toCGPath().takeRetainedValue())
                    ctx.fillPath()
                } else if m == 5 {
                    let p = it.element.hairlinePath
                    let sk = SKPath(cgPath: p)
                    let stroked = sk.copyStroking(withWidth: width, lineCap: .round, lineJoin: .round, miterLimit: 0, resolutionScale: 1e-10)
                    strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                        c.eachPathSegment({ (cp) in
                            let skcp = SKPath(cgPath: cp)
                            stroked.subtract(skcp)
                        })
                    })
                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(stroked.toCGPath().takeRetainedValue())
                    ctx.fillPath()
                } else if m == 4 {
                    let p = CGMutablePath()
                    it.element.eachPathSegment({ (o) in
                        var sub = o
                        strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                            sub = sub.subtract(path: c.path)
                        })
                        p.addPath(sub)
                    })
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p)
                    ctx.fillPath()
                } else if m == 3 {
                    //NG
                    var p: CGPath = CGMutablePath()
                    it.element.eachPathSegment({ (o) in
                        var sub = o
                        strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                            sub = sub.subtract(path: c.path)
                        })
                        p = p.union(with: sub)
                    })
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p)
                    ctx.fillPath()
                } else if m == 2 {
                    //NG
                    var p = it.element.path
                    strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                        c.eachPathSegment({ (c) in
                            p = p.subtract(path: c)
                        })
                    })
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p)
                    ctx.fillPath()
                } else if m == 1 {
                    //NG
                    var p: CGPath = CGMutablePath()
                    it.element.eachPathSegment({ (o) in
                        p = p.union(with: o)
                    })
                    strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                        c.eachPathSegment({ (cp) in
                            p = p.subtract(path: cp)
                        })
                    })
                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p)
                    ctx.fillPath()
                } else if m == 0 {
                    //NG
                    var p = it.element.path
                    strokes.dropFirst(it.offset + 1).filter({ $0.alpha <= 0 }).forEach({ (c) in
                        p = p.subtract(path: c.path)
                    })

                    ctx.saveGState()
                    defer {
                        ctx.restoreGState()
                    }

                    ctx.setFillColor(it.element.color.cgColor)
                    ctx.addPath(p)
                    ctx.fillPath()
                }
            })
        case .frame:
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
                ctx.setLineWidth(1 / UIScreen.main.scale)
                ctx.setStrokeColor(it.element.color.cgColor)
                ctx.addPath(p)
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
