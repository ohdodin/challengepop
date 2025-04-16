import Foundation

struct User {
    var lastSelectedCategory: Category
    var lastSelectedDifficulty: Difficulty
    var lastSelectedDate: Date
    var lastRecordDate: Date
    var challengeRecords: [ChallengeRecord]
    var totalRecords: Int
}
