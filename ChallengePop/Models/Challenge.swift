import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    var category: Category
    var difficulty: Difficulty
    var title: String
    var description: String
    var recommendedTime: String
    var recommendedPlace: String
}

enum ChallengeData {
    // 건강 (Health)
    static let health_easy = Challenge(
            category: .health,
            difficulty: .easy,
            title: "하루 10분 스트레칭하기",
            description: "전신을 부드럽게 풀어주는 10분 스트레칭으로\n몸과 마음의 긴장을 내려놓아보세요.",
            recommendedTime: "아침 기상 직후 / 자기 전",
            recommendedPlace: "매트를 깐 바닥"
        )
        
        static let health_medium = Challenge(
            category: .health,
            difficulty: .medium,
            title: "1일 8000보 걷기",
            description: "규칙적인 걷기를 통해 심혈관 건강을 지켜보세요.\n도보 앱으로 체크하면 좋아요.",
            recommendedTime: "오후/저녁 산책 시간",
            recommendedPlace: "근처 공원 또는 동네 한 바퀴"
        )
        
        static let health_hard = Challenge(
            category: .health,
            difficulty: .hard,
            title: "주 3회 유산소 + 근력 운동",
            description: "운동 루틴을 계획하고 지켜보세요.\n초반엔 힘들어도 금방 적응돼요!",
            recommendedTime: "자신 있는 시간대",
            recommendedPlace: "헬스장 또는 집 운동 공간"
        )
        
        // 생활습관 (Lifestyle)
        static let lifestyle_easy = Challenge(
            category: .lifestyle,
            difficulty: .easy,
            title: "아침에 물 한 잔 마시기",
            description: "하루의 시작을 수분 보충으로 건강하게!",
            recommendedTime: "기상 직후",
            recommendedPlace: "주방 또는 침대 옆"
        )
        
        static let lifestyle_medium = Challenge(
            category: .lifestyle,
            difficulty: .medium,
            title: "1일 1정리 하기",
            description: "하루에 한 공간이라도 깔끔하게 정리해보세요.\n작은 습관이 쌓이면 큰 변화가 생겨요.",
            recommendedTime: "자기 전",
            recommendedPlace: "방 안 또는 책상"
        )
        
        static let lifestyle_hard = Challenge(
            category: .lifestyle,
            difficulty: .hard,
            title: "일주일간 스마트폰 사용 시간 2시간 이하로 제한",
            description: "디지털 디톡스로 집중력을 회복해보세요.\n사용 시간 기록 앱을 활용해보면 좋아요.",
            recommendedTime: "전 시간대",
            recommendedPlace: "전 생활 공간"
        )
        
        // MARK: - 학습 (Learning)
        static let learning_easy = Challenge(
            category: .learning,
            difficulty: .easy,
            title: "하루 10분 책 읽기",
            description: "짧은 시간이라도 꾸준한 독서는 큰 힘이 됩니다.",
            recommendedTime: "쉬는 시간 / 자기 전",
            recommendedPlace: "침대, 소파, 카페"
        )
        
        static let learning_medium = Challenge(
            category: .learning,
            difficulty: .medium,
            title: "1일 1단어 외우기",
            description: "외국어나 관심 있는 분야의 단어를 하루에 하나씩 익혀보세요.",
            recommendedTime: "아침 또는 점심 후",
            recommendedPlace: "책상, 메모장, 핸드폰 앱"
        )
        
        static let learning_hard = Challenge(
            category: .learning,
            difficulty: .hard,
            title: "하루 1시간 집중 학습",
            description: "정해진 주제에 대해 몰입해서 공부하는 습관을 만들어봐요.",
            recommendedTime: "자기 전 또는 오전 집중 시간",
            recommendedPlace: "조용한 공간"
        )
        
        // 소통 (Communication)
        static let communication_easy = Challenge(
            category: .communication,
            difficulty: .easy,
            title: "하루 한 번 안부 인사하기",
            description: "가족이나 친구에게 따뜻한 인사 한 마디를 건네보세요.",
            recommendedTime: "아침 또는 저녁",
            recommendedPlace: "문자, 메신저, 직접 대면"
        )
        
        static let communication_medium = Challenge(
            category: .communication,
            difficulty: .medium,
            title: "친구에게 감사 메시지 보내기",
            description: "고마웠던 일들을 떠올리며 감사를 전해보세요.\n관계가 더 따뜻해질 거예요.",
            recommendedTime: "틈날 때",
            recommendedPlace: "메신저, 문자"
        )
        
        static let communication_hard = Challenge(
            category: .communication,
            difficulty: .hard,
            title: "하루 1명과 깊은 대화 나누기",
            description: "가벼운 인사를 넘어서 진심 어린 대화를 나눠보세요.\n서로를 이해하는 시간이 됩니다.",
            recommendedTime: "저녁",
            recommendedPlace: "조용하고 편안한 공간"
        )
        
        // 전체 목록
        static let all: [Challenge] = [
            health_easy, health_medium, health_hard,
            lifestyle_easy, lifestyle_medium, lifestyle_hard,
            learning_easy, learning_medium, learning_hard,
            communication_easy, communication_medium, communication_hard
        ]
}
