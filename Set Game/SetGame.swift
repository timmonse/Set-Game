//
//  SetGame.swift
//  Set Game
//
//  Created by Evan Timmons on 6/6/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import Foundation

struct SetGame {
    
    private(set) var cards: [Card]
    
    init() {
        cards = Array<Card>()
        var cardID = 1
        for shape in cardShape.allCases {
            for color in cardColor.allCases {
                for fill in cardFill.allCases {
                    for numberOfShapes in 0..<3 {
                        let cardContent = CardContent(shape: shape, color: color, fill: fill, numberOfShapes: numberOfShapes)
                        let card = Card(content: cardContent, id: cardID)
                        cardID += 1
                        
                        cards.append(card)
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    enum cardShape: Int, CaseIterable{
        case shapeOne
        case shapeTwo
        case shapeThree
    }
    
    enum cardColor: Int, CaseIterable{
        case colorOne
        case colorTwo
        case colorThree
    }
    
    enum cardFill: Int, CaseIterable{
        case fillOne
        case fillTwo
        case fillThree
    }
    
    let shapeOne = cardShape.shapeOne
    let shapeTwo = cardShape.shapeTwo
    let shapeThree = cardShape.shapeThree
    
    let colorOne = cardColor.colorOne
    let colorTwo = cardColor.colorTwo
    let colorThree = cardColor.colorThree
    
    let fillOne = cardFill.fillOne
    let fillTwo = cardFill.fillTwo
    let fillThree = cardFill.fillThree
    
    struct CardContent {
        let shape: cardShape
        let color: cardColor
        let fill: cardFill
        let numberOfShapes: Int
    }
    
    struct Card: Identifiable {
        var isFaceUp : Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
