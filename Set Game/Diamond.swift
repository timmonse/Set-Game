//
//  Diamond.swift
//  Memorize
//
//  Created by Evan Timmons on 6/3/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let topPoint = CGPoint(
            x: rect.midX,
            y: 0
        )
        let leftPoint = CGPoint(
            x: 0,
            y: rect.midY
        )
        let rightPoint = CGPoint(
            x: rect.maxX,
            y: rect.midY
        )
        let bottomPoint = CGPoint(
            x: rect.midX,
            y: rect.maxY
        )
        
        var p = Path()
        p.move(to: leftPoint)
        p.addLine(to: topPoint)
        p.addLine(to: rightPoint)
        p.addLine(to: bottomPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: topPoint)
        return p
    }
}
