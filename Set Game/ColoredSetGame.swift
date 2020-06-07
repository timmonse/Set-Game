//
//  ColoredSetGame.swift
//  Set Game
//
//  Created by Evan Timmons on 6/6/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import SwiftUI

class ColoredSetGame: ObservableObject {
    @Published private var model: SetGame = ColoredSetGame.createSetGame()
    
    private static func createSetGame() -> SetGame {
        SetGame()
    }
    
    var cardColor = [Color(red: 50/255, green: 168/255, blue: 151/255), Color(red: 105/255, green: 105/255, blue: 250/255), Color(red: 254/255, green: 189/255, blue: 255/255)]
    
    var cardFill = [1, 0.5, 0]
    
    // MARK: - Access to the model
    
    var cards: Array<SetGame.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(card : SetGame.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
    
    //TODO: - FIX THIS to show the current cards
    var currentCards: Array<SetGame.Card> {
        var temp = Array<SetGame.Card>()
        for index in 0..<12 {
            temp.append(model.cards[index])
        }
        return temp
    }
    
    func newGame() {
        model = ColoredSetGame.createSetGame()
    }
    
    @ViewBuilder
    func getShapeView(card: SetGame.Card, color: Color, fill: Double, width: CGFloat) -> some View {
        ZStack {
            self.getShape(card: card, color: color, fill: fill)
            self.getShapeStroke(card: card, color: color, width: width)
        }
    }
    
    @ViewBuilder
    func getShape(card: SetGame.Card, color: Color, fill: Double) -> some View {
        //return Text("Hello")
        Group {
            if(card.content.shape == .shapeOne) {
                Diamond()
                .fill(color)
                .opacity(fill)
            } else if (card.content.shape == .shapeTwo) {
                Capsule()
                .fill(color)
                .opacity(fill)
            } else {
                Rectangle()
                .fill(color)
                .opacity(fill)
            }
        }
    }
    
    @ViewBuilder
    func getShapeStroke(card: SetGame.Card, color: Color, width: CGFloat) -> some View {
        //return Text("Hello")
        Group {
            if(card.content.shape == .shapeOne) {
                Diamond()
                .stroke(lineWidth: width)
                .fill(color)
            } else if (card.content.shape == .shapeTwo) {
                Capsule()
                .stroke(lineWidth: width)
                .fill(color)
            } else {
                Rectangle()
                .stroke(lineWidth: width)
                .fill(color)
            }
        }
    }
}
