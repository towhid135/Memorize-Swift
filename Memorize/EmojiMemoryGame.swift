//VIEWMODEL
import SwiftUI

class EmojiMemoryGame:ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static var emojis:[String] = ["🛵","🚗","🚀","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🛺","🚔","🚍","🚲","🛴","🚖","🚡","🚠","🚞" ]
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 3){ pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // Mark: - Intent(s)
    func choose (_ card: Card){
        model.choose(card)
    }
}
