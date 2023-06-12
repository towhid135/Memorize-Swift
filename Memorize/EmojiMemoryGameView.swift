import SwiftUI



struct EmojiMemoryGameView: View {
    @ObservedObject var gameViewModel:EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(gameViewModel.cards){ card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                gameViewModel.choose(card)
                            }
                    }
                }
                .foregroundColor(.red)
               
            }
        
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
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale:CGFloat = 0.8
    }
}

struct SymbolBtn: View {
    var action: () -> Void;
    var labelName: String?
    var body: some View {
        Button(action:{action()}, label: {
            Image(systemName: labelName!)
        })
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(gameViewModel:game).preferredColorScheme(.dark)
        EmojiMemoryGameView(gameViewModel:game).previewInterfaceOrientation(.portrait).preferredColorScheme(.light)
            
    }
}
