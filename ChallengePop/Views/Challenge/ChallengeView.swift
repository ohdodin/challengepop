import Foundation
import SwiftUI

struct ChallengeView: View {

    @State private var selectedCategory: Category? = nil
    @State private var selectedDifficulty: Difficulty? = nil
    @State private var step: Int = 0 // 0: 카테고리, 1: 난이도, 2: 확인
    var selectedChallenge: Challenge? {
        guard let category = selectedCategory,
            let difficulty = selectedDifficulty
        else { return nil }
        return ChallengeData.getChallengeData(
            category: category,
            difficulty: difficulty
        )
    }
    @Binding var user: User
    @Binding var tabSelection: Int
    @AppStorage("isSelected") var isSelected: Bool = false
    @AppStorage("isWritten") var isWritten: Bool = false

    var body: some View {
        ZStack {
            Color(Color(.background)).ignoresSafeArea()

            switch step {
            case 0:
                SelectCategoryCard
            case 1:
                SelectDifficultyCard
            case 2:
                ChallengeConfirmCard
            case 3:
                ChallengeDetailCard
            default:
                EmptyView()
            }
        }
        .navigationTitle("도전과제")

    }

    // MARK: - 0. 도전과제 선택 뷰
    var SelectCategoryCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()

            VStack(spacing: 24) {

                // 설명 문구
                IntroMessage(plain1: "오늘의 ", point: "도전과제", plain2: "를 선택하세요")

                // 카테고리 선택 버튼 리스트
                Grid(
                    alignment: .center,
                    horizontalSpacing: 16,
                    verticalSpacing: 16
                ) {
                    GridRow {
                        categoryCell(category: Category.allCases[0])
                        categoryCell(category: Category.allCases[1])
                    }
                    GridRow {
                        categoryCell(category: Category.allCases[2])
                        categoryCell(category: Category.allCases[3])
                    }
                }
            }
            .frame(
                width: UIScreen.main.bounds.width - 72,
                height: UIScreen.main.bounds.height - 490
            )

            Spacer()

            // 다음버튼
            Button {
                if selectedCategory != nil {
                    step = 1
                }
            } label: {
                NavigationButton(
                    text: "다음",
                    isDisabled: .constant(selectedCategory == nil)
                )
            }

            .disabled(selectedCategory == nil)

        }
        .padding(36)
    }

    // 도전과제 버튼
    private func categoryCell(category: Category) -> some View {
        Button {
            selectedCategory = category
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .stroke(
                        selectedCategory == category
                            ? Color(.mainOrange) : Color(.border),
                        lineWidth:
                            selectedCategory == category ? 3 : 1
                    )
                VStack {
                    Image(category.imageName)
                        .resizable()
                        .frame(
                            width: 100,
                            height: 100,
                            alignment: .center
                        )
                    Text(category.rawValue)
                        .foregroundColor(
                            Color(.black)
                        )
                }
            }
        }

    }

    // MARK: 1. 난이도 선택 뷰
    var SelectDifficultyCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()

            VStack(spacing: 24) {
                Spacer()

                // 설명 문구
                IntroMessage(plain1: "오늘의 ", point: "난이도", plain2: "를 선택하세요")

                // 선택된 카테고리
                ChallengeCard(
                    text: selectedCategory?.rawValue,
                    imageName: selectedCategory?.imageName
                )
                .padding(.bottom, 16)

                // 난이도 선택 버튼 리스트
                VStack(
                    spacing: 16
                ) {
                    difficultyCell(difficulty: Difficulty.allCases[0])
                    difficultyCell(difficulty: Difficulty.allCases[1])
                    difficultyCell(difficulty: Difficulty.allCases[2])

                }
            }
            .frame(
                width: UIScreen.main.bounds.width - 72,
                height: 340
            )

            Spacer()

            // 다음 버튼
            Button {
                if selectedCategory != nil {
                    step = 2
                }
            } label: {
                NavigationButton(
                    text: "다음",
                    isDisabled: .constant(selectedDifficulty == nil)
                )
            }
            .disabled(selectedDifficulty == nil)
        }
        .padding(36)

    }

    // 난이도 셀
    private func difficultyCell(difficulty: Difficulty) -> some View {
        Button {
            selectedDifficulty = difficulty
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .stroke(
                        selectedDifficulty == difficulty
                            ? Color(.mainOrange) : Color(.border),
                        lineWidth:
                            selectedDifficulty == difficulty ? 3 : 1
                    )
                VStack {
                    Text(difficulty.rawValue)
                        .foregroundColor(
                            Color(.black)
                        )
                }
            }
        }
        .frame(height: 60)

    }

    // MARK: 2. 도전과제 확인 뷰
    var ChallengeConfirmCard: some View {
        Group {
            if let category = selectedCategory,
                let difficulty = selectedDifficulty,
                let challenge = selectedChallenge
            {
                VStack {
                    Spacer()

                    // 설명 문구
                    IntroMessage(
                        plain1: "오늘의 도전과제를 ",
                        point: "확인",
                        plain2: "하세요."
                    )

                    // 선택된 도전과제
                    ChallengeCard(
                        text: ((category.rawValue) + " | "
                            + (difficulty.rawValue)),
                        imageName: category.imageName
                    )
                    .padding(.bottom, 16)

                    // 도전과제 보기
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .stroke(Color(.border), lineWidth: 1)
                        VStack(spacing: 24) {
                            Text(challenge.emoji)
                                .font(.system(size: 100))
                            Text(challenge.title)
                                .font(.title3)
                                .bold()
                        }
                    }
                    .frame(height: 300)

                    Spacer()

                    // 도전할래요 버튼
                    Button {
                        user.challengeRecords.append(
                            ChallengeRecord(
                                challenge: challenge
                            )
                        )
                        isSelected = true
                        step = 3
                    } label: {
                        NavigationButton(
                            text: "도전할래요!",
                            isDisabled: .constant(false)
                        )
                    }
                }
                .padding(36)
            }
        }
    }

    // MARK: 3. 도전 상세 뷰
    var ChallengeDetailCard: some View {
        Group{
            if let challenge = selectedChallenge
            {
                VStack {
                    Spacer()
                    
                    // 도전과제 보기
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .stroke(.border, lineWidth: 1)
                            VStack(spacing: 24) {
                                ChallengeCard(text: challenge.title, emoji: challenge.emoji, background: Color(.white))
                                Text(challenge.emoji)
                                    .font(.system(size: 100))
                                Text(challenge.description)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(24)
                        }

                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Text("추천 시간:")
                                    .bold()
                                Text(challenge.recommendedTime)
                            }
                            HStack {
                                Text("추천 장소:")
                                    .bold()
                                Text(challenge.recommendedPlace)
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                    // 체크하러가기 버튼
                    if !isWritten {
                        Button {
                            tabSelection = 1
                        } label: {
                            NavigationButton(
                                text: "체크하러 가기",
                                isDisabled: .constant(false)
                            )
                        }
                    }
                    
                }
                .padding(36)
            }
        }
    }

}

#Preview {
    @State var tabSelection: Int = 0
    @State var user = User()
    ChallengeView(user: $user, tabSelection: $tabSelection)
}
