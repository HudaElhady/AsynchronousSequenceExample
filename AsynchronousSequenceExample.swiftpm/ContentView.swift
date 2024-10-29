import SwiftUI

struct ContentView: View {
    @State var textToShow: String = ""
    
    var body: some View {
        VStack {
            Text(textToShow)
                .font(.headline)
                .fontWeight(.bold)
        }
        .onAppear() {
            Task {
                for try await phrase in TypingSequence(phrase: "Huda Elhady") {
                    textToShow = phrase
                }
            }
        }
    }
}
