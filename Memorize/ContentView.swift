import SwiftUI



struct ContentView: View {
    @ObservedObject var viewModel:EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards){ card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
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
    let card: MemoryGame<String>.Card
    var body: some View {
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
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle).foregroundColor(.orange)

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
        ContentView(viewModel:game).preferredColorScheme(.dark)
        ContentView(viewModel:game).previewInterfaceOrientation(.portrait).preferredColorScheme(.light)
            
    }
}
