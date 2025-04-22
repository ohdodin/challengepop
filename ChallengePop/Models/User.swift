//import Foundation
//import SwiftData
//
//@Model
//class User {
//    @Attribute(.unique) var id: UUID
//    var lastSelectedCategory: Category?
//    var lastSelectedDifficulty: Difficulty?
//
//    @Relationship(deleteRule: .cascade)
//    var challengeRecords: [ChallengeRecord]
//
//    var totalRecords: Int
//    var mbti: String?
//
//    init(
//        id: UUID = UUID(),
//        lastSelectedCategory: Category? = nil,
//        lastSelectedDifficulty: Difficulty? = nil,
//        totalRecords: Int = 0,
//        mbti: String? = nil,
//        challengeRecords: [ChallengeRecord] = []
//    ) {
//        self.id = id
//        self.lastSelectedCategory = lastSelectedCategory
//        self.lastSelectedDifficulty = lastSelectedDifficulty
//        self.totalRecords = totalRecords
//        self.mbti = mbti
//        self.challengeRecords = challengeRecords
//    }
//}
//
////struct User {
////    var lastSelectedCategory: Category? = nil
////    var lastSelectedDifficulty: Difficulty? = nil
////    var challengeRecords: [ChallengeRecord] = []
////    var totalRecords: Int = 0
////    var mbti: String? = nil
////
////    mutating func addChallengeRecord(_ record: ChallengeRecord) {
////        challengeRecords.append(record)
////        totalRecords += 1
////    }
////
////    func getChallengeRecords () -> [ChallengeRecord] {
////        return challengeRecords.filter { $0.isDone != nil }
////    }
////
////    func getTodayChallengeRecord (today: Date) -> [ChallengeRecord] {
////        return challengeRecords.filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
////    }
////}
