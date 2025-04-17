import SwiftUI

struct ChallengeConfirmView: View {
    
    @State var isDisabled: Bool = false
    @Binding var selectedCategory: Category?
    @Binding var selectedDifficulty: Difficulty?
    @Binding var tabSelection: Int
    @EnvironmentObject var user: User
    @AppStorage("isSelected") var isSelected: Bool = false


    var body: some View {
        ZStack {
            Color(Color(.background)).ignoresSafeArea()

            VStack {
                Spacer()

                // 설명 문구
                IntroMessage(plain1: "오늘의 도전과제를 ", point: "확인", plain2: "하세요.")

                // 선택된 도전과제
                ChallengeCard(
                    text: ((selectedCategory?.rawValue ?? "") + " | " + (selectedDifficulty?.rawValue ?? "")),
                    imageName: selectedCategory?.imageName
                )
                .padding(.bottom, 16)

                // 도전과제 보기
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .stroke(Color(.border), lineWidth: 1)
                    VStack(spacing: 24) {
                        Text("🧘🏻")
                            .font(.system(size: 100))
                        Text("하루 10분 스트레칭 하기")
                            .font(.title3)
                            .bold()
                    }
                }
                .frame(height: 300)

                Spacer()

                // 도전할래요 버튼
                NavigationLink {
                    ChallengeDetailView(tabSelection: $tabSelection)
                        .environmentObject(user)
                } label: {
                    NavigationButton(text: "도전할래요!", isDisabled: $isDisabled)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    user.challengeRecords.append(ChallengeRecord(challenge: Challenge(category: selectedCategory ?? Category.health, difficulty: selectedDifficulty ?? Difficulty.easy)))
                    isSelected = true
                })
                // nil 경우 수정 필요
            }
            .padding(36)

        }
        .navigationTitle("도전과제")

    }
}

#Preview {
    ChallengeConfirmView(
        selectedCategory: .constant(Category.lifestyle),
        selectedDifficulty: .constant(Difficulty.easy),
        tabSelection: .constant(0)
    )
    .environmentObject(User())
}
