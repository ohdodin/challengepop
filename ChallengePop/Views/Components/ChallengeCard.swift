import SwiftUI

struct ChallengeCard: View {
    var text: String?
    var imageName: String?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("BackgroundColor"))
                .stroke(Color("BorderColor"), lineWidth: 1)
            HStack {
                Image(imageName ?? "lifestyle")
                    .resizable()
                    .frame(width: 48, height: 48)
                Text(text ?? "미리보기")
                    .foregroundColor(
                        Color("BlackColor")
                    )
            }
        }
        .frame(height: 60)
    }
}
