//
//  ColoredSetGameView.swift
//  Set Game
//
//  Created by Evan Timmons on 6/6/20.
//  Copyright © 2020 Evan Timmons. All rights reserved.
//

import SwiftUI

struct ColoredSetGameView: View {
    @ObservedObject var viewModel = ColoredSetGame()
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut){
                    self.viewModel.newGame()
                }
            },label: { Text("New Game") })
            .frame(width: 350, height: 10, alignment: Alignment.trailing)
            Text("Set Game")
                .font(Font.largeTitle)
            Grid(viewModel.currentCards) { card in
                CardView(viewModel: self.viewModel, card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
        }
        .padding()
    }
}

struct CardView: View {
    var viewModel: ColoredSetGame
    var card: SetGame.Card
    
    var body: some View {
        GeometryReader { geomerty in
            self.body(for: geomerty.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isChosen || !card.isMatched {
            Group {
                VStack {
                    ForEach(0 ..< self.card.content.numberOfShapes+1) { number in
                        self.viewModel.getShapeView(
                            card: self.card,
                            color: self.viewModel.cardColor[self.card.content.color.rawValue],
                            fill: self.viewModel.cardFill[self.card.content.fill.rawValue],
                            width: self.strokeWidth)
                    }
                }
            }
            .padding(10)
            .cardify(isFaceUp: true, isChosen: card.isChosen)
            .transition(AnyTransition.scale)
        }
    }
    
    //MARK: - Drawing Constants
    private let strokeWidth: CGFloat = 4.0
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ColoredSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ColoredSetGameView()
    }
}
