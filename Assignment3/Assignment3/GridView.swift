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
        // Drawing code
    }

}
