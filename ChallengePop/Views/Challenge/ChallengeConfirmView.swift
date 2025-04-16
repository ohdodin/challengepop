import SwiftUI

struct ChallengeConfirmView: View {
        @Binding var selectedCategory: Category?
        @Binding var selectedDifficulty: Difficulty?
    
    
    var body: some View {
        VStack {
            Text(selectedCategory?.rawValue ?? "미리보기")
            Text(selectedDifficulty?.rawValue ?? "미리보기")
            NavigationLink {
                ChallengeDetailView()
            } label: {
                Text("Challenge Accept!")
            }
        }
    }
}

#Preview {
    ChallengeConfirmView(selectedCategory: .constant(nil), selectedDifficulty: .constant(nil))
}

