//VIEWMODEL
import SwiftUI

class EmojiMemoryGame:ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static var emojis:[String] = ["🛵","🚗","🚀","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🛺","🚔","🚍","🚲","🛴","🚖","🚡","🚠","🚞" ]
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 6){ pairIndex in
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
    func shuffle() {
        model.shuffle()
    }
    
    func reset(){
        /*
         Re-creating the model will re-build the body of the view
         */
        model = EmojiMemoryGame.createMemoryGame()
    }
}
