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
                //withAnimation(.easeInOut){
                    self.viewModel.newGame()
                //}
            },label: { Text("New Game") })
            Spacer()
            Text("Set Game").font(Font.largeTitle)
            Grid(viewModel.getShownCards()) { card in
                CardView(viewModel: self.viewModel, card: card).onTapGesture {
                    //withAnimation(.easeInOut(duration: 0.5)) {
                       self.viewModel.choose(card: card)
                    //}
                }
                .padding(5)
            }
            .padding()
            Button(action: {
                //withAnimation(.easeInOut){
                    self.viewModel.dealThree()
                //}
            },label: { Text("Deal 3 More Cards") })
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
        VStack {
            ForEach(0 ..< self.card.content.numberOfShapes+1) { number in
                self.viewModel.getShapeView(
                    card: self.card,
                    color: self.viewModel.cardColors[self.card.content.color.rawValue],
                    fill: self.viewModel.cardFills[self.card.content.fill.rawValue],
                    width: self.strokeWidth)
                    .aspectRatio(4/3, contentMode: .fit)
            }
        }
        .padding(10)
        .cardify(isFaceUp: true, isChosen: card.isChosen, isPartOfAValidSet: card.isPartOfAValidSet)
        .aspectRatio(3/4, contentMode: .fit)
        //.transition(.offset(x: CGFloat(Int.random(in: -1000..<1000)), y: CGFloat(Int.random(in: -1000..<1000))))
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
