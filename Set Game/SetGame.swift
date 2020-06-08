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
    private(set) var chosenCards: [Card]
    
    init() {
        cards = Array<Card>()
        chosenCards = Array<Card>()
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
        //cards.shuffle()
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isChosen }.only }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isChosen = true
                }
                else {
                    cards[index].isChosen = false
                }
            }
        }
    }
    
    mutating func removeValidSetCards(){
        // Remove the matching set from the deck
        for card in chosenCards {
            let removalIndex = cards.firstIndex(matching: card)!
            cards.remove(at: removalIndex)
            chosenCards.removeAll()
        }
    }
    
    mutating func choose(card : Card) {
        if let chosenIndex = cards.firstIndex(matching: card) {
            if !cards[chosenIndex].isChosen && !cards[chosenIndex].isPartOfAValidSet {
                if chosenCards.count == 1 {
                    // Choose additional card
                    chosenCards.append(cards[chosenIndex])
                    cards[chosenIndex].isChosen = true
                } else if chosenCards.count == 2 {
                    // Choose third card
                    chosenCards.append(cards[chosenIndex])
                    cards[chosenIndex].isChosen = true
                    
                    // Check for a valid set
                    if chosenCards.isSet() {
                        for card in chosenCards {
                            let index = cards.firstIndex(matching: card)!
                            cards[index].isPartOfAValidSet = true
                        }
                    }
                }
                else {
                    if chosenCards.count == 3 && chosenCards.isSet() {
                        removeValidSetCards()
                    }
                    
                    //Clear the chosen cards array
                    chosenCards.removeAll()
                    
                    // Add the current card
                    chosenCards.append(cards[chosenIndex])
                    
                    // Deselect other cards and select the current card
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
            } else if !cards[chosenIndex].isPartOfAValidSet {
                // Allow for deselection of cards
                cards[chosenIndex].isChosen = false
                let chosenIndexFromChosenCards = chosenCards.firstIndex(matching: card)!
                chosenCards.remove(at: chosenIndexFromChosenCards)
            }
        }
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
    
    struct CardContent: Equatable {
        let shape: cardShape
        let color: cardColor
        let fill: cardFill
        let numberOfShapes: Int
    }
    
    struct Card: Identifiable, Equatable {
        var isChosen : Bool = false
        var isPartOfAValidSet: Bool = false
        var content: CardContent
        var id: Int
    }
}
