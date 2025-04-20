enum Category: String, CaseIterable, Codable {
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
    
    var beadName: String {
        switch self {
        case .health: return "bead_health"
        case .lifestyle: return "bead_lifestyle"
        case .learning: return "bead_learning"
        case .communication: return "bead_communication"
        }
    }
}
