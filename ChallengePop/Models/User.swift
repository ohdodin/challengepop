import Foundation

struct User {
    var lastSelectedCategory: Category? = nil
    var lastSelectedDifficulty: Difficulty? = nil
    var challengeRecords: [ChallengeRecord] = []
    var totalRecords: Int = 0
    var mbti: String? = nil
}
