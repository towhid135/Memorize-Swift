//
//  ContentView.swift
//  Memorize
//
//  Created by Bayshore Communication on 5/6/23.
//

import SwiftUI



struct ContentView: View {
    var emojis:[String] = ["🚗","🚀","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🛺","🚔","🚍","🛵","🚲","🛴","🚖","🚡","🚠","🚞" ]
    @State var emojiCount = 4;
    func addEmojiHandler () -> Void {
        if emojiCount < 24 {
            emojiCount += 1
        }
    }
    func removeEmojiHandler () -> Void {
        if(emojiCount > 1){
            emojiCount -= 1;
        }
    }
    var body: some View {
        
        VStack {
            ScrollView(showsIndicators: false){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis.indices[0..<emojiCount],id:\.self){ index in
                        CardView(content: emojis[index], isFaceUp: true)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            Spacer(minLength: 10)
            HStack{
                SymbolBtn(action: removeEmojiHandler, labelName: "minus.circle")
                Spacer()
                SymbolBtn(action: addEmojiHandler, labelName: "plus.circle")
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
        
       
      
    }
}

struct CardView: View {
    @State var content: String?
    @State var isFaceUp:Bool
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
            if isFaceUp {
                shape.fill(.white)
               shape.strokeBorder(lineWidth: 3)
                Text(content!).font(.largeTitle).foregroundColor(.orange)
                    
            }else{
               shape.fill(.red)
            }
        }
        /*
         View modifiers of View combiners like Zstack has effect on
         elements inside of it.
         */
        .onTapGesture {
             isFaceUp = !isFaceUp
        }
       
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
        ContentView().preferredColorScheme(.dark)
        ContentView().previewInterfaceOrientation(.portrait).preferredColorScheme(.light)
            
    }
}
