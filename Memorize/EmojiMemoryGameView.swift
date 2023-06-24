import SwiftUI



struct EmojiMemoryGameView: View {
    @ObservedObject var gameViewModel:EmojiMemoryGame
    @Namespace private var dealingNameSpace
    
    var body: some View {
        VStack {
            gameBody
            deckBody
            shuffle
        }
        .padding(.horizontal)
        
       
      
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndeal(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    var gameBody: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3){ card in
            if isUndeal(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            }else{
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .padding(4)
                    //combined transition for appearance and disappearance
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity).animation(.easeInOut(duration: 5))  )
                    //.transition(AnyTransition.scale.animation(Animation.easeInOut(duration: 2)))
                    .onTapGesture {
                        withAnimation{
                            gameViewModel.choose(card)
                        }
                    }
            }
        }
//        .onAppear{
//            withAnimation{
//                for card in gameViewModel.cards {
//                    deal(card)
//                }
//            }
//        }
        .foregroundColor(.red)
        
    }
    
    var deckBody: some View {
        /*
         When dealt set contains the id of every card then the
         deckBody will be disappeard. because isUndeal will return false for
         every card.
         */
        ZStack{
            ForEach (gameViewModel.cards.filter(isUndeal)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity).animation(.easeInOut(duration: 5))  )
            }
        }
        .frame(width: CardConstants.undealtWidth,height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 3)){
                for card in gameViewModel.cards {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle"){
            withAnimation{
                gameViewModel.shuffle()
            }
        }
    }
    
    private struct CardConstants {
            static let color = Color.red
            static let aspectRatio: CGFloat = 2/3
            static let dealDuration: Double = 0.5
            static let totalDealDuration: Double = 2
            static let undealtHeight: CGFloat = 90
            static let undealtWidth: CGFloat =  undealtHeight * aspectRatio
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    var body: some View {
        GeometryReader { geometry in
            /*
             Zstack is a function and its last parameter content is
             a closure funtion. So, we can pass the closure parameter like
             this
             Zstack() {
             }
             instead of
             ZStack (content: {
             } )
             */
            ZStack {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).opacity(0.5).padding(5)
                    Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 4).repeatForever(autoreverses: false))
                    .font(Font.system(size: 32))
                    .scaleEffect(scale(sizeThatFits: geometry.size))
                    
            }
            .cardify(isFaceUp: card.isFaceUp)
            
            
            /*
             View modifiers of View combiners like Zstack has effect on
             elements inside of it.
             */
            
        }
      
       
    }
    
    private func scale(sizeThatFits size: CGSize) ->CGFloat {
        return min(size.width,size.height) / (DrawingConstants.fontSize/DrawingConstants.fontScale)
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width,size.height) * DrawingConstants.fontScale )
    }
    
    private struct DrawingConstants {
        static let fontScale:CGFloat = 0.65
        static let fontSize:CGFloat = 32
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(gameViewModel:game).preferredColorScheme(.dark)
//        EmojiMemoryGameView(gameViewModel:game).previewInterfaceOrientation(.portrait).preferredColorScheme(.light)
            
    }
}
