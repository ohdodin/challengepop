enum Category: String, CaseIterable {
    case health = "건강"
    case lifestyle = "생활습관"
    case learning = "학습"
    case communication = "소통"
    
    var imageName: String {
        switch self {
        case .health: return "health"
        case .lifestyle: return "lifestyle"
        case .learning: return "learning"
        case .communication: return "communication"
        }
    }
}
