import Foundation

class ChallengeRecord: Identifiable, ObservableObject {
    let id = UUID()
    let challenge: Challenge
    @Published var isCompleted: Bool
    @Published var isDone: Bool
    var date: Date
    var content: String?

    init(
        challenge: Challenge,
        isCompleted: Bool = false,
        isDone: Bool = false,
        date: Date = Date(),
        content: String? = nil
    ) {
        self.challenge = challenge
        self.isCompleted = isCompleted
        self.isDone = isDone
        self.date = date
        self.content = content
    }
}
