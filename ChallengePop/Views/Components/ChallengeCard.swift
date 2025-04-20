import SwiftUI

struct ChallengeCard: View {
    var text: String?
    var imageName: String?
    var emoji: String?
    var background: Color = Color(.background)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(background)
                .stroke(Color(.border), lineWidth: 1)
            HStack {
                if imageName != nil {
                    Image(imageName ?? "")
                        .resizable()
                        .frame(width: 48, height: 48)
                }
                if emoji != nil {
                    Text(emoji ?? "")
                        .font(.largeTitle)
                }
                Text(text ?? "")
                    .foregroundColor(
                        Color(.black)
                    )
            }
        }
        .frame(height: 60)
    }
}
