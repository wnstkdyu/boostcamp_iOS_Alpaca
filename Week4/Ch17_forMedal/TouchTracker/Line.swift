//
//  Line.swift
//  TouchTracker
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import CoreGraphics
import Foundation

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero {
        didSet {
            updateAngle()
            print(self.angle)
        }
    }
    var angle = CGFloat()
    
    init(begin: CGPoint, end: CGPoint) {
        self.begin = begin
        self.end = end
        self.angle = {
            let radian = atan2(-(end.y - begin.y), end.x - begin.x)
            let degree = radian * 180 / CGFloat.pi
            return degree
        }()
    }
    
    mutating func updateAngle() {
        let radian = atan2(-(self.end.y - self.begin.y), self.end.x - self.begin.x)
        let degree = radian * 180 / CGFloat.pi
        self.angle = degree
    }
}
