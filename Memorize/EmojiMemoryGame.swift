//VIEWMODEL
import SwiftUI

class EmojiMemoryGame {
    static var emojis:[String] = ["🚗","🚀","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🛺","🚔","🚍","🛵","🚲","🛴","🚖","🚡","🚠","🚞" ]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4){ pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
}
