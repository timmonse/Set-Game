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
                    //self.viewModel.newGame()
                }
            },label: { Text("New Game") })
            .frame(width: 350, height: 10, alignment: Alignment.trailing)
            Text("Set Game")
                .font(Font.largeTitle)
            Grid(viewModel.currentCards) { card in
                CardView(viewModel: self.viewModel, card: card).onTapGesture {
                    
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
        if card.isFaceUp || !card.isMatched {
            //viewModel.getShape(card: card)
            Group {
                ZStack {
                    getShape(card: card, color: viewModel.cardColor[card.content.color.rawValue], fill: viewModel.cardFill[card.content.fill.rawValue])
                    getShapeStroke(card: card, color: viewModel.cardColor[card.content.color.rawValue], width: 5.0)
                }
            }
            .padding(10)
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
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
    
    //MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ColoredSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ColoredSetGameView()
    }
}
