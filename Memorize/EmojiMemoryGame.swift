//VIEWMODEL
import SwiftUI

class EmojiMemoryGame:ObservableObject {
    static var emojis:[String] = ["🚗","🚀","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🛺","🚔","🚍","🛵","🚲","🛴","🚖","🚡","🚠","🚞" ]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 3){ pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // Mark: - Intent(s)
    func choose (_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
