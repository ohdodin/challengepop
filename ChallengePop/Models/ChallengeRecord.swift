import Foundation

struct ChallengeRecord: Identifiable {
    let id = UUID()
    var challenge: Challenge
    var isCompleted: Bool = false
    var date: Date = Date()
    var content: String? = nil

}
