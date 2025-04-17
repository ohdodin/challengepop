import Foundation
import SwiftUI

struct SelectCategoryView: View {

    @State private var selectedCategory: Category? = nil
    @State private var isDisabled: Bool = true
    @Binding var tabSelection: Int
    @EnvironmentObject var user: User
    
    var body: some View {
            ZStack {
                Color(Color(.background)).ignoresSafeArea()

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
                                cell(category: Category.allCases[0])
                                cell(category: Category.allCases[1])
                            }
                            GridRow {
                                cell(category: Category.allCases[2])
                                cell(category: Category.allCases[3])
                            }
                        }
                    }
                    .frame(
                        width: UIScreen.main.bounds.width - 72,
                        height: UIScreen.main.bounds.height - 490
                    )

                    Spacer()

                    // 다음버튼
                    NavigationLink {

                        SelectDifficultyView(
                            selectedCategory: $selectedCategory,
                            tabSelection: $tabSelection
                        )
                        .environmentObject(user)

                    } label: {
                        NavigationButton(text: "다음", isDisabled: $isDisabled)
                    }
                    .disabled(selectedCategory == nil)

                }
                .padding(36)

            }
            .navigationTitle("도전과제")

        
    }
    
    // 도전과제 버튼
    private func cell(category: Category) -> some View {
        Button {
            selectedCategory = category
            isDisabled = false
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .stroke(
                        selectedCategory == category
                            ? Color("MainColor") : Color("BorderColor"),
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
                            Color("BlackColor")
                        )
                }
            }
        }

    }
}

#Preview {
    @State var tabSelection: Int = 0
    
    SelectCategoryView(tabSelection: $tabSelection)
        .environmentObject(User())

}
