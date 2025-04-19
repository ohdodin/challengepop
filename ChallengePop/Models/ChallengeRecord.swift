import Foundation

struct ChallengeRecord: Identifiable {
    let id = UUID()
    let challenge: Challenge
    var isDone: Bool = false
    var isWritten: Bool = false
    var date: Date = Date()
    var content: String? = nil
    
    mutating func updateIsDone(to isDone: Bool) {
        self.isDone = isDone
    }
    
    mutating func updateContent(to newContent: String) {
            self.content = newContent
            self.isWritten = true
        }
}
