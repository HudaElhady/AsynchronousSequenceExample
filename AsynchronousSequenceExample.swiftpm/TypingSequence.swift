
import Foundation

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

        try await Task.sleep(nanoseconds: 500_000_000)
        
        let result = String(phrase[phrase.startIndex...index])
        index = phrase.index(after: index)
        return result
    }
}
