//
//  GridView.swift
//  Assignment3
//
//  Created by Douglas Newman on 3/26/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    @IBInspectable var size: Int = 20 {
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
        
        (0 ... self.size).forEach { i in
            // draw vertical lines
            drawLine(
                start: CGPoint(x: rect.origin.x + (rect.size.width / CGFloat(self.size) * CGFloat(i)), y: rect.origin.y),
                end: CGPoint(x: rect.origin.x + (rect.size.width / CGFloat(self.size) * CGFloat(i)), y: rect.origin.y + rect.size.height)
            )
            
            // draw horizontal lines
            drawLine(
                start: CGPoint(x: rect.origin.x, y: rect.origin.y + (rect.size.height / CGFloat(self.size) * CGFloat(i))),
                end: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + (rect.size.height / CGFloat(self.size) * CGFloat(i)))
            )
        }
        
    }
    
    // draw a line
    func drawLine(start: CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        path.lineWidth = gridWidth
        path.move(to: start)
        path.addLine(to: end)
        gridColor.setStroke()
        path.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = nil
    }
    
    typealias Position = (row: Int, col: Int)
    var lastTouchedPosition: Position?
    
    func process(touches: Set<UITouch>) -> Position? {
        guard touches.count == 1 else { return nil }
        let pos = convert(touch: touches.first!)
        guard lastTouchedPosition?.row != pos.row
            || lastTouchedPosition?.col != pos.col
            else { return pos }
        grid[(pos.col,pos.row)] = grid[(pos.col,pos.row)].toggle()
        setNeedsDisplay()
        return pos
    }
    
    func convert(touch: UITouch) -> Position {
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let row = touchY / gridHeight * CGFloat(size)
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let col = touchX / gridWidth * CGFloat(size)
        let position = (row: Int(row), col: Int(col))
        return position
    }

}
