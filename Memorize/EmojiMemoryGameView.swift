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
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size)).foregroundColor(.orange)

                }
                else if card.isMatched{
                    shape.opacity(0)
                }
                else{
                   shape.fill(.red)
                }
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
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale:CGFloat = 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(gameViewModel:game).preferredColorScheme(.dark)
        EmojiMemoryGameView(gameViewModel:game).previewInterfaceOrientation(.portrait).preferredColorScheme(.light)
            
    }
}
