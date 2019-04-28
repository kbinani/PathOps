//
//  ViewController.swift
//  Example
//
//  Created by kbinani on 2019/04/28.
//  Copyright © 2019 kbinani. All rights reserved.
//

import UIKit
import PathOpsSwift

@IBDesignable
class ContentView : UIView {
    private var size: CGSize = .zero

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }

        ctx.saveGState()
        defer {
            ctx.restoreGState()
        }

        ctx.setFillColor(UIColor.gray.cgColor)
        ctx.fill(self.bounds)

        let r1 = CGRect(x: 0, y: 0, width: 400, height: 300)
        let r2 = CGRect(x: 200, y: 150, width: 400, height: 300)

        let p1 = CGPath(rect: r1, transform: nil)
        let p2 = CGPath(rect: r2, transform: nil)

        let sub = p1.subtract(path: p2)

        let boundingBox = [p1, p2, sub].reduce(CGRect.null) { (last, p) -> CGRect in
            return last.union(p.boundingBoxOfPath)
        }

        ctx.translateBy(x: self.bounds.midX - boundingBox.midX, y: self.bounds.midY - boundingBox.midY)

        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fill(boundingBox.insetBy(dx: -50, dy: -50))

        ctx.setLineWidth(2)
        ctx.setStrokeColor(UIColor.blue.cgColor)
        ctx.stroke(r1)

        ctx.setLineWidth(2)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.stroke(r2)

        ctx.addPath(sub)
        ctx.setFillColor(UIColor.gray.withAlphaComponent(0.5).cgColor)
        ctx.fillPath()
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
}


class ViewController: UIViewController {
    @IBOutlet weak var contentView: ContentView!
}
