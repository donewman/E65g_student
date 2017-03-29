//
//  GridView.swift
//  Assignment3
//
//  Created by Douglas Newman on 3/26/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    @IBInspectable var size = 20 {
        didSet {
            grid = Grid(size,size)
        }
    }
    @IBInspectable var livingColor = UIColor.green
    @IBInspectable var bornColor =  UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.6)
    @IBInspectable var emptyColor = UIColor.darkGray
    @IBInspectable var diedColor = UIColor.init(white: 2/3, alpha: 0.6)
    @IBInspectable var gridColor = UIColor.black
    @IBInspectable var gridWidth = CGFloat(2.0)
    
    var grid = Grid(20,20)

    override func draw(_ rect: CGRect) {
        let size = CGSize(
            width: rect.size.width / CGFloat(self.size),
            height: rect.size.height / CGFloat(self.size)
        )
        let base = rect.origin
        (0 ..< self.size).forEach { i in
            (0 ..< self.size).forEach { j in
                let origin = CGPoint(
                    x: base.x + (CGFloat(i) * size.width),
                    y: base.y + (CGFloat(j) * size.height)
                )
                let subRect = CGRect(
                    origin: origin,
                    size: size
                )
                let path = UIBezierPath(ovalIn: subRect)
                if grid[(i,j)] == .alive {
                    livingColor.setFill()
                } else if grid[(i,j)] == .born {
                    bornColor.setFill()
                } else if grid[(i,j)] == .empty {
                    emptyColor.setFill()
                } else if grid[(i,j)] == .died {
                    diedColor.setFill()
                }
                path.fill()
            }
        }
        
        for i in (0 ... self.size) {
            let verticalPath = UIBezierPath()
            let start = CGPoint(
                x: rect.origin.x + (rect.size.width / CGFloat(self.size) * CGFloat(i)),
                y: rect.origin.y
            )
            let end = CGPoint(
                x: rect.origin.x + (rect.size.width / CGFloat(self.size) * CGFloat(i)),
                y: rect.origin.y + rect.size.height
            )
            verticalPath.lineWidth = gridWidth
            verticalPath.move(to: start)
            verticalPath.addLine(to: end)
            gridColor.setStroke()
            verticalPath.stroke()
        }
        
        for i in (0 ... self.size) {
            let horizontalPath = UIBezierPath()
            let start = CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + (rect.size.height / CGFloat(self.size) * CGFloat(i))
            )
            let end = CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + (rect.size.height / CGFloat(self.size) * CGFloat(i))
            )
            horizontalPath.lineWidth = gridWidth
            horizontalPath.move(to: start)
            horizontalPath.addLine(to: end)
            gridColor.setStroke()
            horizontalPath.stroke()
        }
    }
}
