//
//  DrawView.swift
//  TouchTracker
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        finishedLineColor.setStroke()
        for line in finishedLines {
            changeColorByAngle(line: line).setStroke()
            strokeLine(line: line)
        }
        
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            changeColorByAngle(line: line).setStroke()
            strokeLine(line: line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 이벤트의 순서를 확인하기 위한 로그문
        print("Touches Began!")
        
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 이벤트의 순서를 확인하기 위한 로그문
        print("Touches Moved!")
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 이벤트의 순서를 확인하기 위한 로그문
        print("Touches Ended!")
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            guard var line = currentLines[key] else { break }
            line.end = touch.location(in: self)
            
            finishedLines.append(line)
            currentLines.removeValue(forKey: key)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 이벤트의 순서를 확인하기 위한 로그문
        print("Touches Cancelled!")
        
        currentLines.removeAll()
        
        setNeedsDisplay()
    }
    
    func changeColorByAngle(line: Line) -> UIColor {
        let angle = line.angle
        var color = UIColor()
        
        switch angle {
        case -180 ..< -90:
            color = UIColor.black
        case -90..<0:
            color = UIColor.blue
        case 0..<90:
            color = UIColor.yellow
        default:
            color = UIColor.red
        }
        
        return color
    }
}
