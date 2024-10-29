# AsynchronousSequenceExample

This project demonstrates how to implement a typing animation effect in SwiftUI using the `AsyncSequence` protocol. The animation shows text being typed out character by character with a delay between each character.

## Overview

The implementation consists of three main components:

1. A SwiftUI view that displays the animated text
2. A custom `AsyncSequence` implementation (`TypingSequence`)
3. An async iterator (`TypingSequenceIterator`) that handles the character-by-character animation

## Implementation Details

### ContentView

```swift
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
```

The `ContentView` uses `@State` to manage the text being displayed and updates it using an async for loop when the view appears.

### TypingSequence

```swift
class TypingSequence: AsyncSequence {
    typealias Element = String
    let phrase: String
    
    init(phrase: String) {
        self.phrase = phrase
    }
    
    func makeAsyncIterator() -> TypingSequenceIterator {
        TypingSequenceIterator(phrase: phrase)
    }
}
```

`TypingSequence` conforms to `AsyncSequence` and provides the infrastructure for iterating over the characters of a phrase.

### TypingSequenceIterator

```swift
class TypingSequenceIterator: AsyncIteratorProtocol {
    let phrase: String
    var index: String.Index
    
    init(phrase: String) {
        self.phrase = phrase
        self.index = phrase.startIndex
    }
    
    func next() async throws -> String? {
        guard index < phrase.endIndex else {
            return nil
        }

        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let result = String(phrase[phrase.startIndex...index])
        index = phrase.index(after: index)
        return result
    }
}
```

The iterator handles the actual animation by:
- Keeping track of the current position in the string
- Adding a 1-second delay between characters
- Returning progressively longer substrings of the original phrase
