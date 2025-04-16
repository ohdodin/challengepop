import Foundation

struct ChallengeRecord: Identifiable {
    let id = UUID()
    var challenge: Challenge
    var isCompleted: Bool
    var date: Date
    var content: String
}
