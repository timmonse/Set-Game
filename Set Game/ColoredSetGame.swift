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
    
    var cardColor = [Color.blue, Color.red, Color.green]
    
    var cardFill = [1, 0.5, 0]
    
    // MARK: - Access to the model
    
    var cards: Array<SetGame.Card> {
        model.cards
    }
    
    //TODO: - FIX THIS to show the current cards
    var currentCards: Array<SetGame.Card> {
        var temp = Array<SetGame.Card>()
        for index in 0..<10 {
            temp.append(model.cards[index])
        }
        return temp
    }
    
    @ViewBuilder
    func getShape(card: SetGame.Card) -> some View {
        if(card.content.shape == .shapeOne) {
            Diamond()
        } else if (card.content.shape == .shapeTwo) {
            Capsule()
        } else {
            Rectangle()
        }
    }
    
    @ViewBuilder
    func createCardView(cardID: Int) -> some View {
        Text("\(cardID)")
    }
    
}

struct ColoredSetGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
