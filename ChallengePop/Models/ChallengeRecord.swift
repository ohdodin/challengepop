import Foundation
import SwiftData
import SwiftUI

@Model
class ChallengeRecord : Identifiable {
    @Attribute(.unique) var id: UUID
    var isDone: Bool?
    var content: String?
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade)
    var challenge: Challenge
    
    //    @Relationship(inverse: \User.challengeRecords)
    //    var user: User
    
    init(
        id: UUID = UUID(),
        isDone: Bool? = nil,
        content: String? = nil,
        createdAt: Date = Date(),
        challenge: Challenge
        //        user: User,
    ) {
        self.id = id
        self.isDone = isDone
        self.content = content
        self.createdAt = createdAt
        self.challenge = challenge
        //        self.user = user
    }
}
    
//    func getTodayChallengeRecord() -> ChallengeRecord? {
//        guard Calendar.current.isDate(date, inSameDayAs: Date()) else { return nil }
//        return self
//    }
//    
//    func updateIsDone(to value: Bool) {
//        self.isDone = value
//    }
//
//    func deleteContent() {
//        self.content = nil
//        self.isWritten = false
//    }

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
