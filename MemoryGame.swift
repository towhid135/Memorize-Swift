//MODEL
import Foundation


struct MemoryGame<CardContent> {
    //read only
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card) -> Void {
        
    }
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>();
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp:Bool = true
        var isMatched:Bool = false
        var content: CardContent
    }
}
