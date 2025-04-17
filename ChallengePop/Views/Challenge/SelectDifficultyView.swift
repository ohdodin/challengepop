import Foundation
import SwiftUI

struct SelectDifficultyView: View {
    @State private var selectedDifficulty: Difficulty? = nil
    @State private var isDisabled: Bool = true
    @Binding var selectedCategory: Category?
    @Binding var tabSelection: Int
    @EnvironmentObject var user: User

    var body: some View {
        ZStack {
            Color(Color("BackgroundColor")).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                VStack(spacing: 24) {
                    Spacer()

                    // 설명 문구
                    IntroMessage(plain1: "오늘의 ", point: "난이도", plain2: "를 선택하세요")

                    // 선택된 카테고리
                    ChallengeCard(text: selectedCategory?.rawValue ?? "미리보기", imageName: selectedCategory?.imageName ?? "lifestyle")
                        .padding(.bottom, 16)

                    // 난이도 선택 버튼 리스트
                    VStack(
                        spacing: 16
                    ) {
                        cell(difficulty: Difficulty.allCases[0])
                        cell(difficulty: Difficulty.allCases[1])
                        cell(difficulty: Difficulty.allCases[2])

                    }
                }
                .frame(
                    width: UIScreen.main.bounds.width - 72,
                    height: 340
                )

                Spacer()

                // 다음 버튼
                NavigationLink {
                    ChallengeConfirmView(
                        selectedCategory: $selectedCategory,
                        selectedDifficulty: $selectedDifficulty,
                        tabSelection: $tabSelection
                    )
                    .environmentObject(user)

                } label: {
                    NavigationButton(text: "다음", isDisabled: $isDisabled)
                    
                }
                .disabled(selectedDifficulty == nil)

            }
            .padding(36)

        }
        .navigationTitle("도전과제")
    }

    // 난이도 버튼
    private func cell(difficulty: Difficulty) -> some View {
        Button {
            selectedDifficulty = difficulty
            isDisabled = false
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .stroke(
                        selectedDifficulty == difficulty
                            ? Color("MainColor") : Color("BorderColor"),
                        lineWidth:
                            selectedDifficulty == difficulty ? 3 : 1
                    )
                VStack {
                    Text(difficulty.rawValue)
                        .foregroundColor(
                            Color("BlackColor")
                        )
                }
            }
        }
        .frame(height: 60)

    }
}

#Preview {
    SelectDifficultyView(
        selectedCategory: .constant(nil),
        tabSelection: .constant(0)
    )
    .environmentObject(User())
}
