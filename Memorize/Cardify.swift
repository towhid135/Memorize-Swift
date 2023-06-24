//Its a ViewModifier
import SwiftUI

struct Cardify: AnimatableModifier {
    let isFaceUp:Bool
    var rotation: Double
    
    init(isFaceUp:Bool){
        self.isFaceUp = isFaceUp
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
            }
            else{
                shape.fill(.red)
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale:CGFloat = 0.65
    }
}

extension View {
    func cardify(isFaceUp:Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
