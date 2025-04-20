import Foundation
import SwiftData
import SwiftUI

@Model
class ChallengeRecord {
    @Attribute(.unique) var id: UUID
    var isDone: Bool?
    var isWritten: Bool
    var date: Date
    var content: String?

    @Relationship(inverse: \User.challengeRecords)
    var user: User

    @Relationship(deleteRule: .nullify)
    var challenge: Challenge

    init(
        id: UUID = UUID(),
        isDone: Bool? = nil,
        isWritten: Bool = false,
        date: Date = Calendar.current.startOfDay(for: Date()),
        content: String? = nil,
        user: User,
        challenge: Challenge
    ) {
        self.id = id
        self.isDone = isDone
        self.isWritten = isWritten
        self.date = date
        self.content = content
        self.user = user
        self.challenge = challenge
    }

    func updateIsDone(to value: Bool) {
        self.isDone = value
    }

    func updateContent(to newContent: String) {
        self.content = newContent
    }

    func deleteContent() {
        self.content = nil
        self.isWritten = false
    }
}

//struct ChallengeRecord: Identifiable {
//    let id = UUID()
//    let challenge: Challenge
//    var isDone: Bool? = nil
//    var isWritten: Bool = false
//    var date: Date = Date()
//    var content: String? = nil
//
//    mutating func updateIsDone(to isDone: Bool) {
//        self.isDone = isDone
//    }
//
//    mutating func updateContent(to newContent: String) {
//            self.content = newContent
//            self.isWritten = true
//        }
//
//    mutating func deleteContent() {
//        self.content = nil
//        self.isWritten = false
//    }
//}
