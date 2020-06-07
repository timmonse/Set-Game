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
    var isPartOfAValidSet: Bool
    
    init(isFaceUp: Bool, isChosen: Bool, isPartOfAValidSet: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isChosen = isChosen
        self.isPartOfAValidSet = isPartOfAValidSet
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
                    .stroke(lineWidth: getCardBorderWidth())
                    .fill(getCardBorderColor())
                content
            }
            .opacity(isFaceUp ? 100 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(AngularGradient(gradient: Gradient(colors: [Color.white, Color.black]), center: UnitPoint()))
                .opacity(isFaceUp ? 0 : 100)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    func getCardBorderWidth() -> CGFloat {
        if isPartOfAValidSet {
            return validSetEdgeLineWidth
        } else if isChosen {
            return selectedEdgeLineWidth
        } else {
            return standardEdgeLineWidth
        }
    }
    
    func getCardBorderColor() -> Color {
        if isPartOfAValidSet {
            return validSetGreen
        } else if isChosen {
            return selectedBlue
        } else {
            return Color.gray
        }
    }
    
    //MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let standardEdgeLineWidth: CGFloat = 3
    private let selectedEdgeLineWidth: CGFloat = 7
    private let validSetEdgeLineWidth: CGFloat = 7
    private let validSetGreen: Color = Color(red: 152/255, green: 245/255, blue: 143/255)
    private let selectedBlue: Color = Color(red: 255/255, green: 190/255, blue: 134/255)
}

extension View {
    func cardify(isFaceUp: Bool, isChosen: Bool, isPartOfAValidSet: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isChosen: isChosen, isPartOfAValidSet: isPartOfAValidSet))
    }
}
