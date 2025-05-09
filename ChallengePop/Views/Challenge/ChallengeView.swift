import Foundation
import SwiftData
import SwiftUI

struct ChallengeView: View {

    @State private var selectedCategory: Category? = nil
    @State private var selectedDifficulty: Difficulty? = nil
    @State private var step: Int = 0  // 0: 카테고리, 1: 난이도, 2: 확인
    @State private var showAlert = false
    @Binding var tabSelection: Int

    @AppStorage("isSelected") var isSelected: Bool = false
    @AppStorage("isWritten") var isWritten: Bool = false
    @AppStorage("today") var today: Date = Date.distantPast

    // MARK: SwiftData
    @Environment(\.modelContext) private var context
    @Query(sort: \ChallengeRecord.createdAt, order: .reverse) private
        var challengeRecords: [ChallengeRecord]  // 값을 불러오는 순서를 보장할 수 없음, sort, created at으로 정렬

    var body: some View {
        ZStack {
            Color(Color(.background)).ignoresSafeArea()
            VStack {
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
            .padding(36)
        }
        .navigationTitle(tabName.challenge.stringValue)
        .toolbar {
            if step > 0 && !isSelected {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        step -= 1
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(.mainOrange))
                            Text("뒤로")
                        }
                    }
                }
            }
        }
        .onAppear {
            if isSelected {
                step = 3
            }
        }
    }

    // MARK: - 0. 도전과제 선택 뷰
    var SelectCategoryCard: some View {
        VStack(spacing: 24) {

            Spacer()

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
            .frame(maxHeight: 320)

            Spacer()

            NavigationButton(
                text: "다음",
                step: $step,
                isDisabled: .constant(selectedCategory == nil)
            )
        }

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

        VStack(spacing: 24) {
            Spacer()

            // 설명 문구
            IntroMessage(plain1: "오늘의 ", point: "난이도", plain2: "를 선택하세요")

            // 선택된 카테고리
            if let category = selectedCategory {
                ChallengeCard(
                    text: category.rawValue,
                    imageName: category.imageName
                )
                .padding(.bottom, 16)
            }

            // 난이도 선택 버튼 리스트
            VStack(
                spacing: 16
            ) {
                difficultyCell(difficulty: Difficulty.allCases[0])
                difficultyCell(difficulty: Difficulty.allCases[1])
                difficultyCell(difficulty: Difficulty.allCases[2])

            }
            Spacer()

            // 다음 버튼
            NavigationButton(
                text: "다음",
                step: $step,
                isDisabled: .constant(selectedDifficulty == nil)
            )
        }
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
    private var ChallengeConfirmCard: some View {
        Group {
            if let category = selectedCategory,
                let difficulty = selectedDifficulty
            {
                VStack {
                    let challenge = Challenge.getChallengeData(
                        category: category,
                        difficulty: difficulty
                    )

                    Spacer()

                    VStack(spacing: 4) {
                        // 설명 문구
                        IntroMessage(
                            plain1: "오늘의 도전과제를 ",
                            point: "확인",
                            plain2: "하세요."
                        )

                        //                        // 선택된 도전과제
                        //                        ChallengeCard(
                        //                            text: ((category.rawValue) + " | "
                        //                                   + (difficulty.rawValue)),
                        //                            imageName: category.imageName
                        //                        )
                    }

                    // 도전과제 보기
                    ChallengePop.ChallengeDetailCard(
                        challenge: Challenge.getChallengeData(
                            category: category,
                            difficulty: difficulty
                        )
                    )

                    Spacer()

                    // 도전할래요 버튼
                    VStack {
                        Text("오늘의 도전을 확정하면 수정이 불가해요!")
                            .font(.caption)
                            .foregroundColor(.darkGray)
                        NavigationButton(
                            text: "도전할래요",
                            step: $step,
                            isDisabled: .constant(false),
                            onTap: {
                                print("selet")
                                isSelected = true
                                addChallenge(challenge: challenge)
                                showAlert = true
                            }
                        )
                    }

                }
            }
        }
    }

    func addChallenge(challenge: Challenge) {
        
        let challengeRecord = ChallengeRecord(challenge: challenge)
        context.insert(challengeRecord)
        
    }

    // MARK: 3. 도전 상세 뷰
    var ChallengeDetailCard: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                if let challengeRecord = firstChallengeRecord() {
                    // 도전과제 카드
                    ChallengePop.ChallengeDetailCard(
                        challenge: challengeRecord.challenge
                    )
                } else {
                    // 여기
                    let _ = print("challengeRecords: \(challengeRecords)")
                }
            }

            Spacer()

            // 체크하러가기 버튼
            if !isWritten {
                NavigationButton(
                    text: "체크하러 가기",
                    step: $tabSelection,
                    isDisabled: .constant(false)
                )

            }

        }
    }

    func firstChallengeRecord() -> ChallengeRecord? {
        //        dump(challengeRecords)
        return challengeRecords.first
    }
}
