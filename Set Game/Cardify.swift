//
//  Cardify.swift
//  Memorize
//
//  Created by Evan Timmons on 6/3/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isChosen: Bool
    
    init(isFaceUp: Bool, isChosen: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isChosen = isChosen
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View{
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: isChosen ? edgeLineWidth * 2 : edgeLineWidth)
                    .fill(isChosen ? Color(red: 152/255, green: 245/255, blue: 143/255) : Color.black)
                content
            }
            .opacity(isFaceUp ? 100 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius).fill(AngularGradient(gradient: Gradient(colors: [Color.white, Color.black]), center: UnitPoint()))
                .opacity(isFaceUp ? 0 : 180)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    
    //MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool, isChosen: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isChosen: isChosen))
    }
}
