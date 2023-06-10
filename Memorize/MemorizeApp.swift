import SwiftUI

@main
struct MemorizeApp: App {
    /*
     class is reference type so it will pass reference of the EmojiMemoryGame class to the game.
     hence, despite of the game variable being "let" type we can make changes to the class data.
     */
    let game = EmojiMemoryGame();
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel:game)
        }
    }
}
