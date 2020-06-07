//
//  Array+isSet.swift
//  Set Game
//
//  Created by Evan Timmons on 6/7/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import Foundation

extension Array where Element == SetGame.Card {
    func isSet() -> Bool {
        if count != 3 {
            return false
        }
        
        let isValidShape: Bool = allSameOrAllDifferent(self[0].content.shape, self[1].content.shape, self[2].content.shape)
        let isValidColor: Bool = allSameOrAllDifferent(self[0].content.color, self[1].content.color, self[2].content.color)
        let isValidFill: Bool = allSameOrAllDifferent(self[0].content.fill, self[1].content.fill, self[2].content.fill)
        let isValidNum: Bool = allSameOrAllDifferent(self[0].content.numberOfShapes, self[1].content.numberOfShapes, self[2].content.numberOfShapes)
        
        if isValidShape && isValidColor && isValidFill && isValidNum {
            return true
        } else {
            return false
        }
    }
}

private func allSameOrAllDifferent<Item>(_ item1: Item, _ item2: Item, _ item3: Item) -> Bool where Item: Equatable {
    // If all the same return true
    if item1 == item2 && item1 == item3 && item2 == item3 {
        return true
    }
    // If all different return true
    else if item1 != item2 && item1 != item3 && item2 != item3 {
        return true
    } else {
        return false
    }
}
