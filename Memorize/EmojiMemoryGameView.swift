import SwiftUI



struct EmojiMemoryGameView: View {
    @ObservedObject var gameViewModel:EmojiMemoryGame
    
    var body: some View {
        VStack {
            
                AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3){ card in
                    if card.isMatched && !card.isFaceUp {
                        Rectangle().opacity(0)
                    }else{
                        CardView(card: card)
                            .padding(4)
                            .onTapGesture {
                                gameViewModel.choose(card)
                            }
                    }
                }
                .foregroundColor(.red)
               
            
        
        }
        .padding(.horizontal)
        
       
      
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
                    Text(card.content).font(font(in: geometry.size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
            }
            
            /*
             View modifiers of View combiners like Zstack has effect on
             elements inside of it.
             */
            
        }
      
       
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width,size.height) * DrawingConstants.fontScale )
    }
    
    private struct DrawingConstants {
        static let fontScale:CGFloat = 0.65
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
