//MODEL
import Foundation


struct MemoryGame<CardContent> where CardContent:Equatable {
    //read only
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard:Int? {
        get {  cards.indices.filter({cards[$0].isFaceUp }).oneAndOnly  }
        
        /*
         During setting the value of indexOfTheOneAndOnlyFaceUpCard, the set function receives the given value in
         "newValue" props
         */
        set { cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)}) }
    }
    
    mutating func choose(_ card: Card) -> Void {
        /*
         this command will not work because all arguments to functions are let
         and we can't modify a let
         */
//        card.isFaceUp.toggle()
        /*
         If a closure function takes one arguments we can replace it with $0 and we don't need the "in" keyword.
         Fore more arguments we can use $0,$1,$2 etc
         */
        if let chosenIndex:Int = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[potentialMatchIndex].content == cards[chosenIndex].content{
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp.toggle()
            }else{
               
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            
        }else{
            print("Card not found!")
        }
       
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    init (numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [];
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content,id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2+1) )
        }
        cards.shuffle()
    }
    
    struct Card:Identifiable {
        var isFaceUp:Bool = false
        var isMatched:Bool = false
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time
                
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}

extension Array {
    var oneAndOnly:Element? {
        if self.count == 1 {
            return first
        }else{
            return nil
        }
    }
}
