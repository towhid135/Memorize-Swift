//MODEL
import Foundation


struct MemoryGame<CardContent> {
    //read only
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) -> Void {
        /*
         this command will not work because all arguments to functions are let
         and we can't modify a let
         */
//        card.isFaceUp.toggle()
        
        let chosenIndex:Int = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
        
      
       
        print("cards: \(cards)")
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count{
            if(cards[index].id == card.id){
                return index
            }
        }
        return 0 //bogus
    }
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>();
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content,id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2+1) )
        }
    }
    
    struct Card:Identifiable {
        var isFaceUp:Bool = true
        var isMatched:Bool = false
        var content: CardContent
        var id: Int
    }
}
