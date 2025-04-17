import Foundation

class User: ObservableObject {
    @Published var lastSelectedCategory: Category? = nil
    @Published var lastSelectedDifficulty: Difficulty? = nil
    @Published var challengeRecords: [ChallengeRecord] = []
    @Published var totalRecords: Int = 0
    @Published var mbti: String? = nil
}
