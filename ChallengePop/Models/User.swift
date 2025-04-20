import Foundation


struct User {
    var lastSelectedCategory: Category? = nil
    var lastSelectedDifficulty: Difficulty? = nil
    var challengeRecords: [ChallengeRecord] = []
    var totalRecords: Int = 0
    var mbti: String? = nil
    
    mutating func addChallengeRecord(_ record: ChallengeRecord) {
        challengeRecords.append(record)
        totalRecords += 1
    }
    
    func getChallengeRecords () -> [ChallengeRecord] {
        return challengeRecords.filter { $0.isDone != nil }
    }
    
    func getTodayChallengeRecord (today: Date) -> [ChallengeRecord] {
        return challengeRecords.filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
    }
}
