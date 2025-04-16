import Foundation
import SwiftUI

struct SelectDifficultyView: View {
    @State private var selectedDifficulty: Difficulty? = nil
    @Binding var selectedCategory: Category?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color("BackgroundColor")).ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("오늘의 ")
                            .font(.headline)
                        Text("난이도")
                            .font(.headline)
                            .foregroundColor(Color("MainColor"))
                        Text("를 선택하세요.")
                            .font(.headline)
                    }

                    Spacer()
                    
                    // 난이도 컨테이너
                    VStack(spacing: 16) {
                        Spacer()
                        
                        // 도전 카테고리
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("BackgroundColor"))
                                .stroke(
                                    Color("BorderColor"),
                                    lineWidth: 1
                                )
                                .frame(
                                    width: (UIScreen.main.bounds.width
                                            - 72), height: 60
                                )
                            Text(selectedCategory?.rawValue ?? "미리보기" )
                        }
                        
                        Spacer()
                        
                        // 난이도 버튼 리스트
                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
                            Button {
                                selectedDifficulty = difficulty                            } label: {
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                        .stroke(
                                            Color("BorderColor"),
                                            lineWidth: 1
                                        )
                                        .frame(
                                            width: (UIScreen.main.bounds.width
                                                    - 72), height: (UIScreen.main.bounds.height - 528) / 3
                                        )
                                    Text(difficulty.rawValue)
                                        .font(.body)
                                        .foregroundColor(Color("BlackColor"))
                                }
                            }
                        }
                        Spacer()
                        
                    }

                    Spacer()
                    
                    // 다음 버튼
                    NavigationLink {

                        ChallengeConfirmView(selectedCategory: $selectedCategory, selectedDifficulty: $selectedDifficulty)

                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    selectedDifficulty == nil
                                        ? Color("DisabledColor")
                                        : Color("MainColor")
                                )
                                .frame(
                                    width: (UIScreen.main.bounds.width - 64),
                                    height: 44
                                )
                            Text("다음")
                                .foregroundColor(.white)

                        }
                    }
                    .disabled(selectedDifficulty == nil)

                }
                .padding(36)

            }
            .navigationTitle("도전과제")

        }
    }
}

#Preview {
    var category = Category.lifestyle
    SelectDifficultyView(selectedCategory: .constant(nil))
}
