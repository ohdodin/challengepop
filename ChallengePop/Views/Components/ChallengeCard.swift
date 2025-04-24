import SwiftUI

struct ChallengeCard: View {
    var text: String?
    var imageName: String?
    var background: Color = Color(.background)

    var body: some View {

        HStack {
            if imageName != nil {
                Image(imageName ?? "")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            Text(text ?? "")
                .font(.headline)
                .foregroundColor(
                    Color(.black)
                )

        }
    }
}

#Preview {
    ChallengeCard(text: "제목")
}
