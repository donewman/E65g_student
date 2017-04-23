//
//  GridView.swift
//  Assignment4
//
//  Created by Douglas Newman on 4/22/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

public protocol GridViewDataSource {
    subscript (row: Int, col: Int) -> CellState { get set }
}

@IBDesignable class GridView: UIView {
    var gridDataSource: GridViewDataSource?
    
    @IBInspectable var gridSize: Int = 10
    @IBInspectable var livingColor = UIColor.green
    @IBInspectable var bornColor =  UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.6)
    @IBInspectable var emptyColor = UIColor.clear
    @IBInspectable var diedColor = UIColor.init(white: 2/3, alpha: 0.6)
    @IBInspectable var gridColor = UIColor.black
    @IBInspectable var gridWidth = CGFloat(2.0)

    override func draw(_ rect: CGRect) {
        drawOvals(rect)
        drawLines(rect)
    }
    
    func drawOvals(_ rect: CGRect) {
        let size = CGSize(
            width: rect.size.width / CGFloat(gridSize),
            height: rect.size.height / CGFloat(gridSize)
        )
        let base = rect.origin
        (0 ..< gridSize).forEach { i in
            (0 ..< gridSize).forEach { j in
                // Inset the oval 2 points from the left and top edges
                let ovalOrigin = CGPoint(
                    x: base.x + (CGFloat(j) * size.width) + 2.0,
                    y: base.y + (CGFloat(i) * size.height + 2.0)
                )
                // Make the oval draw 2 points short of the right and bottom edges
                let ovalSize = CGSize(
                    width: size.width - 4.0,
                    height: size.height - 4.0
                )
                let ovalRect = CGRect( origin: ovalOrigin, size: ovalSize )
                let path = UIBezierPath(ovalIn: ovalRect)
                if let grid = gridDataSource, grid[(i,j)] == .alive {
                    livingColor.setFill()
                } else if let grid = gridDataSource, grid[(i,j)] == .born {
                    bornColor.setFill()
                } else if let grid = gridDataSource, grid[(i,j)] == .empty {
                    emptyColor.setFill()
                } else if let grid = gridDataSource, grid[(i,j)] == .died {
                    diedColor.setFill()
                }
                path.fill()
            }
        }
    }

    func drawLines(_ rect: CGRect) {
        //create the path
        (0 ..< (gridSize + 1)).forEach {
            drawLine(
                start: CGPoint(x: CGFloat($0)/CGFloat(gridSize) * rect.size.width, y: 0.0),
                end:   CGPoint(x: CGFloat($0)/CGFloat(gridSize) * rect.size.width, y: rect.size.height)
            )
            
            drawLine(
                start: CGPoint(x: 0.0, y: CGFloat($0)/CGFloat(gridSize) * rect.size.height ),
                end: CGPoint(x: rect.size.width, y: CGFloat($0)/CGFloat(gridSize) * rect.size.height)
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
    
    var lastTouchedPosition: GridPosition?
    
    func process(touches: Set<UITouch>) -> GridPosition? {
        let touchY = touches.first!.location(in: self.superview).y
        let touchX = touches.first!.location(in: self.superview).x
        guard touchX > frame.origin.x && touchX < (frame.origin.x + frame.size.width) else { return nil }
        guard touchY > frame.origin.y && touchY < (frame.origin.y + frame.size.height) else { return nil }
        
        guard touches.count == 1 else { return nil }
        let pos = convert(touch: touches.first!)
        
        guard lastTouchedPosition?.row != pos.row
            || lastTouchedPosition?.col != pos.col
            else { return pos }
        
        if gridDataSource != nil {
            gridDataSource![pos.row, pos.col] = gridDataSource![pos.row, pos.col].isAlive ? .empty : .alive
            setNeedsDisplay()
        }
        return pos
    }
    
    func convert(touch: UITouch) -> GridPosition {
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let row = touchY / gridHeight * CGFloat(gridSize)
        
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let col = touchX / gridWidth * CGFloat(gridSize)
        
        return GridPosition(row: Int(row), col: Int(col))
    }
}
