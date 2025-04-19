import SwiftUI

enum Charactor {
    enum Weapon {
        case bow
        case sword
        case axe
    }

    enum Armor {
        case chain
        case wooden
        case leather
    }

    case wrriror(weapon: Weapon, armor: Armor)
    case archor(weapon: Weapon, armor: Armor)

    func description() -> String {
        switch self {
        case let .wrriror(weapon, armor):
            return "검사의 무기는 \(weapon) 갑옷은 \(armor) 입니다."
        case let .archor(weapon, armor):
            return "궁수의 무기는 \(weapon) 갑옷은 \(armor) 입니다."

        }
    }
}

enum BatteryStateSwitch {
    case discharge
    case low
    case high
    case full
    
    var description: String {
        switch self {
        case .discharge:
            return "배터리 상태: discharge"
        case .low:
            return "배터리 상태: low"
        case .high:
            return "배터리 상태: high"
        case .full:
            return "배터리 상태: full"
        }
    }
    mutating func charge() {
        switch self {
        case .discharge:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .full
        default:
            print("boom!")
        }
    }
}

struct BootcampExample: View {
    
    let age: Int? = 100
    
    var body: some View {
        let charactor = Charactor.archor(weapon: .sword, armor: .leather)
        Text(charactor.description())

        var batterystate = BatteryStateSwitch.high
        
        let _ = print(
            batterystate.description
        )
        Text(age?.description ?? "100")
    }
}

enum Device {
    case iPhon
    case iPad
    
    static func getDevice(name: String ) -> Device? {
        switch name {
            case "iPhon16":
            return .iPhon
        case "iPadPro":
            return .iPad
        default:
            return nil
        }
    }
}

#Preview {
    BootcampExample()
}
