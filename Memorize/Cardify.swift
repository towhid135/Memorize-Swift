//Its a ViewModifier
import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp:Bool
    let isMatched:Bool
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content
            }
            else if isMatched{
//                shape.opacity(1)
                shape.fill(.red)
            }
            else{
               shape.fill(.red)
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale:CGFloat = 0.65
    }
}

extension View {
    func cardify(isFaceUp:Bool,isMatched:Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
